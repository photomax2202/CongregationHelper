unit uGitHub;

interface

uses
  Windows;

type
  TRelease = record
    Name: string;
    Version: string;
    Datum: TDateTime;
    Link: string;
    Prerelease: Boolean;
  end;

function GetGithubReleases(ARepoOwner: String; AAppRepo: String; out AContent: String): Boolean;
function GetLastRelease(AReleasesText: string; AAppName: String; APreRelease: Boolean; out ADonwloadLink: String;
  out AResult: Boolean): String;
function DownloadRelease(AUrl: String): Boolean;
function IsProcessRunning(const AProcessName: string): Boolean;
procedure StartNewProcess(const ApplicationName, CommandLine: string; AWaitForFinish: Boolean = False);
function GetProcessID(const ProcessName: string): DWORD;
procedure KillProcess(const ProcessName: string);
procedure OpenURLInDefaultBrowser(const URL: string);

implementation

uses
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.Net.URLClient,
  Classes,
  DateUtils,
  Generics.Collections,
  JSON,
  URLMon,
  SysUtils,
  psapi,
  TlHelp32,
  Vcl.Dialogs,
  Winapi.ShellAPI;

function Rfc3339ToDatetime(rfc: string): TDateTime;
var
  jahr, monat, tag, stunde, minute, sekunde: integer;
begin
  // 2025-02-05T19:00:12Z
  // 123456789012345678901234
  jahr    := StrToInt(Copy(rfc, 1, 4));
  monat   := StrToInt(Copy(rfc, 6, 2));
  tag     := StrToInt(Copy(rfc, 9, 2));
  stunde  := StrToInt(Copy(rfc, 12, 2));
  minute  := StrToInt(Copy(rfc, 15, 2));
  sekunde := StrToInt(Copy(rfc, 18, 2));
  result  := EncodeDateTime(jahr, monat, tag, stunde, minute, sekunde, 0);
end;

function ExtractAppFromUrl(AUrl: String): String;
var
  sl: TStringList;
begin
  result := EmptyStr;
  sl     := TStringList.Create;
  try
    sl.Delimiter     := '/';
    sl.DelimitedText := AUrl;
    result           := sl.Strings[sl.Count - 1];
  finally
    sl.Free;
  end;
end;

function GetGithubReleases(ARepoOwner: String; AAppRepo: String; out AContent: String): Boolean;
var
  LHttpClient: TNetHTTPClient;
  LResponse  : IHTTPResponse;
begin
  result      := False;
  AContent    := EmptyStr;
  LHttpClient := TNetHTTPClient.Create(nil);
  try
    LResponse := LHttpClient.Get(Format('https://api.github.com/repos/%s/%s/releases', [ARepoOwner, AAppRepo]));
    if LResponse.StatusCode <> 200 then
      Exit;
    AContent := LResponse.ContentAsString(TEncoding.UTF8);
    result   := True;
  finally
    LHttpClient.Free;
  end;
end;

function GetLastRelease(AReleasesText: string; AAppName: String; APreRelease: Boolean; out ADonwloadLink: String;
  out AResult: Boolean): String;
var
  LReleasesJSON: TJSONArray;
  LReleaseJSON : TJSONObject;
  LAssetsJSON  : TJSONArray;
  LAssetJSON   : TJSONObject;
  i, j         : integer;
  LRelease     : TRelease;
  LReleases    : TList<TRelease>;
  LMaxDate     : TDateTime;
  LPosition    : integer;
  // LFormatSettings:  TFormatSettings;
begin
  LReleasesJSON := TJSONObject.ParseJSONValue(AReleasesText) as TJSONArray;
  LReleases     := TList<TRelease>.Create;
  try
    LMaxDate  := 0;
    LPosition := 0;
    LReleases.Clear;
    for i := 0 to LReleasesJSON.Count - 1 do
    begin
      AResult      := False;
      LReleaseJSON := LReleasesJSON.Items[i] as TJSONObject;
      LAssetsJSON  := LReleaseJSON.GetValue<TJSONArray>('assets');
      for j        := 0 to LAssetsJSON.Count - 1 do
      begin
        LAssetJSON          := LAssetsJSON.Items[j] as TJSONObject;
        LRelease.Name       := LAssetJSON.GetValue('name').Value;
        LRelease.Version    := LReleaseJSON.GetValue('tag_name').Value;
        LRelease.Datum      := Rfc3339ToDatetime(LReleaseJSON.GetValue('published_at').Value);
        LRelease.Link       := LAssetJSON.GetValue('browser_download_url').Value;
        LRelease.Prerelease := StrToBool(LReleaseJSON.GetValue('prerelease').Value);
        if (LRelease.Name = AAppName) and (APreRelease or (LRelease.Prerelease = False)) then
        begin
          LReleases.Add(LRelease);
          if LRelease.Datum > LMaxDate then
          begin
            LMaxDate  := LRelease.Datum;
            LPosition := LReleases.Count - 1;
          end;
        end;
      end;
    end;
    if LReleases.Count > 0 then
    begin
      ADonwloadLink := LReleases[LPosition].Link;
      result        := LReleases[LPosition].Version;
      AResult       := True;
    end;
  finally
    LReleasesJSON.Free;
    // LReleaseJSON.Free;
    // LAssetsJSON.Free;
    // LAssetJSON.Free;
    LReleases.Free;
  end;
end;

function DownloadRelease(AUrl: String): Boolean;
var
  LProgramPath: String;
begin
  try
    result       := False;
    LProgramPath := ExtractFilePath(ParamStr(0)) + ExtractAppFromUrl(AUrl);
    if FileExists(LProgramPath) then
      DeleteFile(PChar(LProgramPath));
    ShowMessage(                                         //
      'Eine Applikation wird nachgeladen:' + #10 + #13 + //
      'URL: ' + AUrl + #10 + #13 +                       //
      'Ziel: ' + LProgramPath);                          //
    UrlDownloadToFile(nil, PChar(AUrl), PChar(LProgramPath), 0, nil);
    result := True;
  except
    result := False;
  end;
end;

function IsProcessRunning(const AProcessName: string): Boolean;
var
  Snapshot    : THandle;
  ProcessEntry: TProcessEntry32;
begin
  result   := False;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot = INVALID_HANDLE_VALUE then
    Exit;

  ProcessEntry.dwSize := SizeOf(ProcessEntry);
  if Process32First(Snapshot, ProcessEntry) then
  begin
    repeat
      if SameText(ProcessEntry.szExeFile, AProcessName) then
      begin
        result := True;
        Break;
      end;
    until not Process32Next(Snapshot, ProcessEntry);
  end;
  CloseHandle(Snapshot);
end;

procedure StartNewProcess(const ApplicationName, CommandLine: string; AWaitForFinish: Boolean = False);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  WaitResult : DWORD;
begin
  ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
  StartupInfo.cb := SizeOf(TStartupInfo);
  ZeroMemory(@ProcessInfo, SizeOf(ProcessInfo));

  if CreateProcess(PChar(ApplicationName), PChar(CommandLine), nil, nil, False, 0, nil, nil, StartupInfo, ProcessInfo)
  then
  begin
    // Auf die Beendigung des Prozesses warten
    if AWaitForFinish then
      WaitResult := WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    // Der Prozess wurde erfolgreich gestartet
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
  begin
    // Fehler beim Starten des Prozesses
    ShowMessage('Fehler beim Starten des Prozesses: ' + SysErrorMessage(GetLastError));
  end;
end;

function GetProcessID(const ProcessName: string): DWORD;
var
  Snapshot    : THandle;
  ProcessEntry: TProcessEntry32;
begin
  result   := 0;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot <> INVALID_HANDLE_VALUE then
    try
      ProcessEntry.dwSize := SizeOf(ProcessEntry);
      if Process32First(Snapshot, ProcessEntry) then
      begin
        repeat
          if SameText(ProcessEntry.szExeFile, ProcessName) then
          begin
            result := ProcessEntry.th32ProcessID;
            Break;
          end;
        until not Process32Next(Snapshot, ProcessEntry);
      end;
    finally
      CloseHandle(Snapshot);
    end;
end;

procedure KillProcess(const ProcessName: string);
var
  ProcessID    : DWORD;
  ProcessHandle: THandle;
begin
  ProcessID := GetProcessID(ProcessName);
  if ProcessID <> 0 then
  begin
    ProcessHandle := OpenProcess(PROCESS_TERMINATE, False, ProcessID);
    if ProcessHandle <> 0 then
      try
        if not TerminateProcess(ProcessHandle, 0) then
          raise Exception.Create('Failed to terminate process');
      finally
        CloseHandle(ProcessHandle);
      end;
  end
  else
    raise Exception.Create('Process not found');
end;

procedure OpenURLInDefaultBrowser(const URL: string);
begin
  if URL <> EmptyStr then
    ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL)
  else
    ShowMessage('Keine URL übergeben.');
end;

end.
