unit uAutoUpdater;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ExtCtrls,
  JSON;

type
  TFormAutoUpdater = class(TForm)
    lbledtAppName: TLabeledEdit;
    lbledtRepoName: TLabeledEdit;
    lbledtAppVersion: TLabeledEdit;
    lbledtUrl: TLabeledEdit;
    btnUpdate: TButton;
    edtAppRunning: TEdit;
    TimerRefresh: TTimer;
    btnAbortUpdate: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerRefreshTimer(Sender: TObject);
    procedure btnAbortUpdateClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    FAppRepo         : String;
    FAppName         : String;
    FAppVersion      : String;
    FAppUrl          : String;
    FAppVersionGitHub: String;
    FAppPreReleases  : Boolean;
    { Private-Deklarationen }
    function GetGithubRelease: Boolean;
    procedure ButtonEnable;
  public
    { Public-Deklarationen }
    property AppRepo: String
      read   FAppRepo;
    property AppName: String
      read   FAppName;
    property AppVersion: String
      read   FAppVersion;
    property AppVersionGitHub: String
      read   FAppVersionGitHub;
    property AppUrl: String
      read   FAppUrl;
    property AppPreReleases: Boolean
      read   FAppPreReleases;
  end;

var
  FormAutoUpdater: TFormAutoUpdater;

implementation

uses
  uGitHub;

{$R *.dfm}

procedure TFormAutoUpdater.btnAbortUpdateClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormAutoUpdater.btnUpdateClick(Sender: TObject);
var
  LAppPath: string;
begin
  KillProcess(AppName);
  Sleep(1000);
  DownloadRelease(AppUrl);
  LAppPath := ExtractFilePath(ParamStr(0)) + AppName;
  StartNewProcess(LAppPath, '');
  Application.Terminate;
end;

procedure TFormAutoUpdater.ButtonEnable;
var
  LEnable: Boolean;
begin
  if IsProcessRunning(AppName) then
  begin
    edtAppRunning.Text := 'App gestartet';
    LEnable            := True;
  end
  else
  begin
    edtAppRunning.Text := 'App nicht gestartet';
    LEnable            := False;
  end;
  LEnable           := LEnable and (FAppVersion <> FAppVersionGitHub);
  btnUpdate.Enabled := LEnable;
end;

procedure TFormAutoUpdater.FormCreate(Sender: TObject);
begin
  FormStyle := fsStayOnTop;
  // �berpr�fe, ob Startparameter vorhanden sind
  if ParamCount <> 4 then
  begin
    ShowMessage( //
      'Startparameter fehlerhaft. Die Applikation wird wieder beendet.' + #10#13 + //
      'Die folgenden Parameter werden unterst�tzt.' + #10#13 + //
      'Parameter:' + #10#13 + //
      '1 --> GitHub-Repo' + #10#13 +          //
      '2 --> Updating Application' + #10#13 + //
      '3 --> Actual Release Tag' + #10#13 +   //
      '4 --> PreReleaseState True/False');    //
    Application.Terminate;
  end;
  FAppRepo        := ParamStr(1);
  FAppName        := ParamStr(2);
  FAppVersion     := ParamStr(3);
  FAppPreReleases := StrToBool(ParamStr(4));
  // Daten des letzten Github Release holen.
  if not GetGithubRelease then
  begin
    ShowMessage('GitHub Releases von ' + AppRepo +
      ' konnten nicht abgerufen werden oder es ist kein passendes Release vorhanden. ' +
      'Die Applikation wird wieder beendet.');
    Application.Terminate;
  end;
{$IFNDEF DEBUG}
  if FAppVersion = FAppVersionGitHub then
    Application.Terminate;
{$ENDIF}
end;

procedure TFormAutoUpdater.FormShow(Sender: TObject);
begin
  lbledtRepoName.Text   := AppRepo;
  lbledtAppName.Text    := AppName;
  lbledtAppVersion.Text := Format('%s [GitHub: %s]', [AppVersion, AppVersionGitHub]);
  lbledtUrl.Text        := AppUrl;
  ButtonEnable;
end;

function TFormAutoUpdater.GetGithubRelease: Boolean;
var
  LResponse     : string;
  i             : Integer;
  LReleaseResult: Boolean;
begin
  Result := False;
  if not GetGithubReleases('photomax2202', AppRepo, LResponse) then
    Exit;
  FAppVersionGitHub := GetLastRelease(LResponse, AppName, FAppPreReleases, FAppUrl, LReleaseResult);
  if not LReleaseResult then
    Exit;
  Result := True;
end;

procedure TFormAutoUpdater.TimerRefreshTimer(Sender: TObject);
begin
  ButtonEnable;
end;

end.
