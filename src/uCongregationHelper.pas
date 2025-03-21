unit uCongregationHelper;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  uConfig,
  Vcl.ComCtrls,
  uPageMaster,
  uGitHub,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type

  TZoomUserState = (stInvalid, stInactive, stOnline, stOffline, stNeedsAttention);

  TFormCongregationHelper = class(TForm)
    mpMainMenu: TMainMenu;
    mpSettings: TMenuItem;
    mpAlwaysOnTop: TMenuItem;
    mpSettingsCamera: TMenuItem;
    mpProgramm: TMenuItem;
    mpExit: TMenuItem;
    mpInfo: TMenuItem;
    mpSettingsMonitor: TMenuItem;
    pgcMain: TPageControl;
    mpHelp: TMenuItem;
    pnlBottom: TPanel;
    pnlZoomUserStage: TPanel;
    pnlZoomUserConference: TPanel;
    tmrZoomUser: TTimer;
    mpZoomMonitoring: TMenuItem;
    mpPreReleaseRepo: TMenuItem;
    pnlZoomActive: TPanel;
    mpSettingsZoom: TMenuItem;
    pnlZoomUserHost: TPanel;
    pnlZoomUserUsher: TPanel;
    pnlZoomUserSound: TPanel;
    mpLog: TMenuItem;
    mpChecklist: TMenuItem;
    mpGeneral: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mpSettingsClick(Sender: TObject);
    procedure mpProgramClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure tmrZoomUserTimer(Sender: TObject);
    procedure CheckZoomUsers;
  private
    FConfig          : TConfig;
    FFunctionPages   : TObjectList<TFormPageMaster>;
    FUpdateApp       : String;
    FFilePath        : String;
    FUpdateAppUrl    : String;
    FTimerIndex      : Integer;
    FZoomMonitoring  : Boolean;
    FPreReleseVersion: Boolean;
    // procedure AddFunctionPages;
    function GetFunctionPages(i: Integer): TFormPageMaster;
    function GetFunctionPage: TFormPageMaster;
    procedure GetUpdateApp;
    function GetAppVersion: string;
    procedure SetZoomUserState(Sender: TPanel; AState: TZoomUserState);
    function GetZoomUserState(Sender: TPanel): TZoomUserState;
    function CreatePages: TArray<TFormPageMaster>;
  public
    property Config: TConfig
      read   FConfig
      write  FConfig;
    property UpdateApp: String
      read   FUpdateApp;
    property UpdateAppUrl: String
      read   FUpdateAppUrl;
    property FilePath: String
      read   FFilePath;
    property FunctionPages[i: Integer]: TFormPageMaster
      read   GetFunctionPages;
    property FunctionPage: TFormPageMaster
      read   GetFunctionPage;
    property ZoomMonitoring: Boolean
      read   FZoomMonitoring;
    property PreReleseVersion: Boolean
      read   FPreReleseVersion;

    procedure DoResize;
  end;

const
  // App Version wird aus compilierten Daten ermittelt
  // cVersion       = 'v0.0.3';
  cRepoName      = 'CongregationHelper';
  cUpdateAppName = 'AutoUpdater.exe';

var
  FormCongregationHelper: TFormCongregationHelper;

implementation

uses
  StrUtils,
  uConfigCamera,
  uConfigMonitor,
  uConfigGeneral,
  uConfigZoom,
  uPageFunctionSample,
  uPageApplication,
  uPageCamera,
  uLog;

{$R *.dfm}
// procedure TFormCongregationHelper.AddFunctionPages;
//
// procedure AddFunctionPage(AForm: TForm);
// begin
// AForm.ManualDock(pgcMain);
// pgcMain.Pages[pgcMain.PageCount - 1].Name := AForm.Name;
// AForm.Show;
// end;
//
// begin
// {$IFDEF DEBUG}
// FormPageFunctionSample := TFormPageFunctionSample.Create(pgcMain);
// AddFunctionPage(FormPageFunctionSample);
// {$ENDIF}
// FormPageApplication := TFormPageApplication.Create(pgcMain);
// AddFunctionPage(FormPageApplication);
// DoResize;
// end;

procedure TFormCongregationHelper.CheckZoomUsers;
begin
  { TODO -oMax -cZoomUsers : Implementation of Checking Zoom user avalibility }

  SetZoomUserState(pnlZoomActive, stOffline);
  SetZoomUserState(pnlZoomUserHost, stOnline);
  SetZoomUserState(pnlZoomUserUsher, stOffline);
  SetZoomUserState(pnlZoomUserSound, stOnline);
  SetZoomUserState(pnlZoomUserStage, stOffline);
  SetZoomUserState(pnlZoomUserConference, stOnline);

end;

function TFormCongregationHelper.CreatePages: TArray<TFormPageMaster>;
var
  LPages: TObjectList<TFormPageMaster>;
begin
  LPages := TObjectList<TFormPageMaster>.Create(False);
  try
    // TODO: für jede Funktion eine EditPage in eigener Unit erstellen und der Liste hinzufügen
{$IFDEF DEBUG}
    LPages.Add(TFormPageFunctionSample.Create(Self));
{$ENDIF}
    LPages.Add(TFormPageCamera.Create(Self));
    LPages.Add(TFormPageApplication.Create(Self));

    Result := LPages.ToArray;
  finally
    LPages.Free;
  end;

end;

procedure TFormCongregationHelper.DoResize;
var
  i                 : Integer;
  LHight            : Integer;
  LPageControlHeight: Integer;
begin
  // LWidth := 0;
  LHight := 0;
  for i  := 0 to pgcMain.PageCount - 1 do
  begin
    // if FunctionPages[i].MaxWidth > LWidth then
    // LWidth := FunctionPages[i].MaxWidth;
    if FunctionPages[i].MaxHeight > LHight then
      LHight := FunctionPages[i].MaxHeight;
  end;
  // Constraints.MinWidth  := 0;
  // Constraints.MaxWidth  := 0;
  Constraints.MinHeight := 0;
  Constraints.MaxHeight := 0;
  // Width                 := Width - pgcMain.Width + LWidth;
  // Constraints.MinWidth  := Width;
  // Constraints.MaxWidth  := Width;
  LPageControlHeight    := pgcMain.ActivePage.Height;
  Height                := Height - LPageControlHeight + LHight;
  Constraints.MinHeight := Height;
  Constraints.MaxHeight := Height;
end;

procedure TFormCongregationHelper.FormCreate(Sender: TObject);
var
  LReleasesText: string;
  LRespose     : string;
  i            : Integer;
begin
  Config                   := TConfig.Create;
  FTimerIndex              := 0;
  mpAlwaysOnTop.Checked    := Config.AlwaysOnTop;
  mpZoomMonitoring.Checked := Config.ZoomMonitoring;
  mpPreReleaseRepo.Checked := Config.PreReleaseVersionen;
{$IFNDEF DEBUG}
  FFilePath  := ParamStr(0);
  FUpdateApp := StringReplace(FFilePath, ExtractFileName(ParamStr(0)), cUpdateAppName, [rfReplaceAll]);
  if not FileExists(FUpdateApp) then
  begin
    GetUpdateApp;
  end;
  StartNewProcess(UpdateApp, Format('%s %s %s %s %s', [UpdateApp, cRepoName, ExtractFileName(FFilePath), GetAppVersion,
    BoolToStr(FPreReleseVersion, True)]), True);
{$ENDIF}
  FFunctionPages := TObjectList<TFormPageMaster>.Create(True);
  FFunctionPages.AddRange(CreatePages);
  for i := 0 to FFunctionPages.Count - 1 do
  begin
    FFunctionPages[i].ManualDock(pgcMain);
    FFunctionPages[i].Show;
  end;
  DoResize;
  // Application.Name    := StringReplace(Caption, ' ', '', [rfReplaceAll]);
  tmrZoomUser.Enabled := True;
end;

procedure TFormCongregationHelper.FormDestroy(Sender: TObject);
begin
  tmrZoomUser.Enabled := False;
  Config.Free;
  FFunctionPages.Free;
end;

procedure TFormCongregationHelper.FormShow(Sender: TObject);
begin
  DoResize;
  // AddFunctionPages;
end;

function TFormCongregationHelper.GetAppVersion: string;
var
  VersionInfoSize, VersionValueSize: DWORD;
  VersionInfo, VersionValue        : Pointer;
  TranslationValue                 : PChar;
  Major, Minor, Release, Build     : Cardinal;
begin
  VersionInfoSize := GetFileVersionInfoSize(PChar(Application.ExeName), VersionValueSize);
  if VersionInfoSize > 0 then
  begin
    GetMem(VersionInfo, VersionInfoSize);
    try
      if GetFileVersionInfo(PChar(Application.ExeName), 0, VersionInfoSize, VersionInfo) then
      begin
        VerQueryValue(VersionInfo, '\', VersionValue, VersionValueSize);
        Major   := HiWord(PVSFixedFileInfo(VersionValue)^.dwFileVersionMS);
        Minor   := LoWord(PVSFixedFileInfo(VersionValue)^.dwFileVersionMS);
        Release := HiWord(PVSFixedFileInfo(VersionValue)^.dwFileVersionLS);
        Build   := LoWord(PVSFixedFileInfo(VersionValue)^.dwFileVersionLS);
        // WriteLn(Format('Version: %d.%d.%d.%d', [Major, Minor, Release, Build]));
        Result := Format('v%d.%d.%d.%d', [Major, Minor, Release, Build]);
      end;
    finally
      FreeMem(VersionInfo);
    end;
  end
  else
    // WriteLn('Keine Versionsinformationen gefunden.');
    Result := EmptyStr;
end;

function TFormCongregationHelper.GetFunctionPage: TFormPageMaster;
begin
  if (pgcMain.ActivePageIndex < 0) and (pgcMain.ActivePageIndex <= FFunctionPages.Count) then
    Result := nil
  else
    Result := FFunctionPages[pgcMain.ActivePageIndex];
end;

function TFormCongregationHelper.GetFunctionPages(i: Integer): TFormPageMaster;
begin
  if (i < 0) and (i <= FFunctionPages.Count) then
    Result := nil
  else
    Result := FFunctionPages[i];
end;

procedure TFormCongregationHelper.GetUpdateApp;
var
  LResponse     : String;
  LReleaseResult: Boolean;
begin
  if not GetGithubReleases('photomax2202', 'CongregationHelper', LResponse) then
    Exit;
  GetLastRelease(LResponse, ExtractFileName(UpdateApp), FPreReleseVersion, FUpdateAppUrl, LReleaseResult);
  if LReleaseResult then
  begin
    if not DownloadRelease(UpdateAppUrl) then
      Exit;
  end;
end;

function TFormCongregationHelper.GetZoomUserState(Sender: TPanel): TZoomUserState;
begin
  if (Sender as TPanel).Color = clGrayText then
    Result := stInactive
  else if (Sender as TPanel).Color = clLime then
    Result := stOnline
  else if (Sender as TPanel).Color = clRed then
    Result := stOnline
  else if (Sender as TPanel).Color = clTeal then
    Result := stNeedsAttention
  else
    Result := stInvalid;
end;

procedure TFormCongregationHelper.mpProgramClick(Sender: TObject);
begin
  if not(Sender is TMenuItem) then
    Exit;
  FormLog.DoLog(Format('Button Programm klick: %s', [(Sender as TMenuItem).Caption]));
  if (Sender as TMenuItem).Name = mpHelp.Name then
  begin
    OpenURLInDefaultBrowser('https://github.com/photomax2202/CongregationHelper/wiki');
  end
  else if (Sender as TMenuItem).Name = mpChecklist.Name then
  begin
    OpenURLInDefaultBrowser(Config.UrlChecklist);
  end
  else if (Sender as TMenuItem).Name = mpInfo.Name then
  begin
    ShowMessage(                            //
      Caption + #10#13 +                    //
      'Version ' + GetAppVersion + #10#13 + //
      'GitHub-Repo: ' + cRepoName           //
      );
  end
  else if (Sender as TMenuItem).Name = mpExit.Name then
  begin
    Application.Terminate;
  end;
end;

procedure TFormCongregationHelper.mpSettingsClick(Sender: TObject);
begin
  if not(Sender is TMenuItem) then
    Exit;
  FormLog.DoLog(Format('Button Einstellungen klick: %s', [(Sender as TMenuItem).Caption]));
  if (Sender as TMenuItem).Name = mpSettingsCamera.Name then
  begin
    FormConfigCamera := TFormConfigCamera.Create(FormCongregationHelper);
    try
      FormConfigCamera.ShowModal;
    finally
      FormConfigCamera.Free;
    end;
    pgcMain.OnChange(Self);
    DoResize;
  end
  else if (Sender as TMenuItem).Name = mpSettingsMonitor.Name then
  begin
    FormConfigMonitor := TFormConfigMonitor.Create(FormCongregationHelper);
    try
      FormConfigMonitor.ShowModal;
    finally
      FormConfigMonitor.Free;
    end;
    pgcMain.OnChange(Self);
    DoResize;
  end
  else if (Sender as TMenuItem).Name = mpSettingsZoom.Name then
  begin
    FormConfigZoom := TFormConfigZoom.Create(FormCongregationHelper);
    try
      FormConfigZoom.ShowModal;
    finally
      FormConfigZoom.Free;
    end;
    pgcMain.OnChange(Self);
    DoResize;
  end
  else if (Sender as TMenuItem).Name = mpGeneral.Name then
  begin
    FormConfigGeneral := TFormConfigGeneral.Create(FormCongregationHelper);
    try
      FormConfigGeneral.ShowModal;
    finally
      FormConfigGeneral.Free;
    end;
    pgcMain.OnChange(Self);
    DoResize;
  end
  else if (Sender as TMenuItem).Name = mpZoomMonitoring.Name then
  begin
    mpZoomMonitoring.Checked := not mpZoomMonitoring.Checked;
    Config.ZoomMonitoring    := mpZoomMonitoring.Checked;
    if mpZoomMonitoring.Checked then
      FZoomMonitoring := True;
  end
  else if (Sender as TMenuItem).Name = mpPreReleaseRepo.Name then
  begin
    mpPreReleaseRepo.Checked   := not mpPreReleaseRepo.Checked;
    FPreReleseVersion          := mpPreReleaseRepo.Checked;
    Config.PreReleaseVersionen := FPreReleseVersion;
    if FPreReleseVersion then
      ShowMessage('Beim nächsten Programmstart werden bei Aktualisierungen Pre-Release Versionen berücksichtigt.')
  end
  else if (Sender as TMenuItem).Name = mpAlwaysOnTop.Name then
  begin
    mpAlwaysOnTop.Checked := not mpAlwaysOnTop.Checked;
    Config.AlwaysOnTop    := mpAlwaysOnTop.Checked;
    if mpAlwaysOnTop.Checked then
      FormStyle := fsStayOnTop
    else
      FormStyle := fsNormal;
  end
  else if (Sender as TMenuItem).Name = mpLog.Name then
  begin
    if FormLog.Visible then
      FormLog.Hide
    else
      FormLog.Show;
  end;
end;

procedure TFormCongregationHelper.pgcMainChange(Sender: TObject);
begin
  if Assigned(FunctionPage) then
  begin
    FunctionPage.FormShow(FunctionPage);
    FunctionPage.DoPageTimer;
  end;
end;

procedure TFormCongregationHelper.SetZoomUserState(Sender: TPanel; AState: TZoomUserState);
begin
  if AState = stInactive then
    (Sender as TPanel).Color := clGrayText
  else if AState = stOnline then
    (Sender as TPanel).Color := clLime
  else if AState = stOffline then
    (Sender as TPanel).Color := clRed
  else if AState = stNeedsAttention then
    (Sender as TPanel).Color := clTeal;
end;

procedure TFormCongregationHelper.tmrZoomUserTimer(Sender: TObject);
begin
  // TimeBase 5000ms
  if not mpZoomMonitoring.Checked and FZoomMonitoring then
  begin
    FZoomMonitoring := False;
    SetZoomUserState(pnlZoomActive, stInactive);
    SetZoomUserState(pnlZoomUserStage, stInactive);
    SetZoomUserState(pnlZoomUserConference, stInactive);
    SetZoomUserState(pnlZoomUserHost, stInactive);
    SetZoomUserState(pnlZoomUserUsher, stInactive);
    SetZoomUserState(pnlZoomUserSound, stInactive);
  end;
  if ((FTimerIndex mod 6) = 0) then
    If FZoomMonitoring then
      CheckZoomUsers;
  if ((FTimerIndex mod 2) = 0) then
  begin
    if Assigned(FunctionPage) then
      FunctionPage.DoPageTimer;
  end;
  Inc(FTimerIndex);
  if FTimerIndex >= 12 then
    FTimerIndex := 0;
end;

end.
