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
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerRefreshTimer(Sender: TObject);
  private
    FAppRepo         : String;
    FAppName         : String;
    FAppVersion      : String;
    FAppUrl          : String;
    FAppVersionGitHub: String;
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
  end;

var
  FormAutoUpdater: TFormAutoUpdater;

implementation

uses
  uGitHub;

{$R *.dfm}

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
  // Überprüfe, ob Startparameter vorhanden sind
  if ParamCount <> 3 then
  begin
    ShowMessage('Keine Startparameter übergeben. Die Applikation wird wieder beendet.' + #10#13 +
      'Die folgenden Parameter werden unterstützt.' + #10#13 + 'Parameter:' + #10#13 + '1 --> GitHub-Repo' + #10#13 +
      '2 --> Updating Application' + #10#13 + '3 --> Actual Release Tag');
    Application.Terminate;
  end;
  FAppRepo    := ParamStr(1);
  FAppName    := ParamStr(2);
  FAppVersion := ParamStr(3);
  // Daten des letzten Github Release holen.
  if not GetGithubRelease then
  begin
    ShowMessage('GitHub Releases von ' + AppRepo +
      'konnten nicht abgerufen werden oder es ist kein passendes Release vorhanden. ' +
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
  LRespose      : string;
  i             : Integer;
  LReleaseResult: Boolean;
begin
  Result := False;
  if not GetGithubReleases('photomax2202', AppRepo, LRespose) then
    Exit;
  FAppVersionGitHub := GetLastRelease(LRespose, AppName, FAppUrl, LReleaseResult);
  if not LReleaseResult then
    Exit;
  Result := True;
end;

procedure TFormAutoUpdater.TimerRefreshTimer(Sender: TObject);
begin
  ButtonEnable;
end;

end.
