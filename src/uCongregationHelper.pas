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

  TZoomUserState = (stInactive, stOnline, stOffline);

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
    cbxZoomUsers: TCheckBox;
    pnlZoomUserStage: TPanel;
    pnlZoomUserConference: TPanel;
    tmrZoomUser: TTimer;
    procedure mpAlwaysOnTopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mpSettingsClick(Sender: TObject);
    procedure mpProgramClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure cbxZoomUsersClick(Sender: TObject);
    procedure tmrZoomUserTimer(Sender: TObject);
    procedure CheckZoomUsers;
  private
    FConfig       : TConfig;
    FFunctionPages: TObjectList<TFormPageMaster>;
    FUpdateApp    : String;
    FFilePath     : String;
    FUpdateAppUrl : String;
    FTimerIndex   : Integer;
    FZoomUserCheck: Boolean;
    { Private-Deklarationen }
    // procedure AddFunctionPages;
    function GetFunctionPages(i: Integer): TFormPageMaster;
    function GetFunctionPage: TFormPageMaster;
    procedure GetUpdateApp;
    procedure SetZoomUserState(Sender: TObject; AState: TZoomUserState);
    function CreatePages: TArray<TFormPageMaster>;
  public
    { Public-Deklarationen }
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
    property ZoomUserCheck: Boolean
      read   FZoomUserCheck;

    procedure DoResize;
  end;

const
  cVersion       = 'v0.0.1_alpha';
  cRepoName      = 'CongregationHelper';
  cUpdateAppName = 'AutoUpdater.exe';

var
  FormCongregationHelper: TFormCongregationHelper;

implementation

uses
  StrUtils,
  uConfigCamera,
  uConfigMonitor,
  uPageFunctionSample,
  uPageApplication;

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

procedure TFormCongregationHelper.cbxZoomUsersClick(Sender: TObject);
begin
  Config.CheckZoomUsers := cbxZoomUsers.Checked;
  if cbxZoomUsers.Checked then
    FZoomUserCheck := True;
end;

procedure TFormCongregationHelper.CheckZoomUsers;
begin
  { TODO -oMax -cZoomUsers : Implementation of Checking Zoom user avalibility }
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
    LPages.Add(TFormPageApplication.Create(Self));

    Result := LPages.ToArray;
  finally
    LPages.Free;
  end;

end;

procedure TFormCongregationHelper.DoResize;
var
  i: Integer;
  // LHight: Integer;
begin
  // LWidth := 0;
  // LHight := 0;
  // for i  := 0 to pgcMain.PageCount - 1 do
  // begin
  // if FunctionPages[i].MaxWidth > LWidth then
  // LWidth := FunctionPages[i].MaxWidth;
  // if FunctionPages[i].MaxHeight > LHight then
  // LHight := FunctionPages[i].MaxHeight;
  // end;
  // Constraints.MinWidth  := 0;
  // Constraints.MaxWidth  := 0;
  // Constraints.MinHeight := 0;
  // Constraints.MaxHeight := 0;
  // Width                 := Width - pgcMain.Width + LWidth;
  // Constraints.MinWidth  := Width;
  // Constraints.MaxWidth  := Width;
  // Height                := Height - pgcMain.Height + LHight;
  // Constraints.MinHeight := Height;
  // Constraints.MaxHeight := Height;
end;

procedure TFormCongregationHelper.FormCreate(Sender: TObject);
var
  LReleasesText: string;
  LRespose     : string;
  i            : Integer;
begin
  FTimerIndex := 0;
{$IFNDEF DEBUG}
  FFilePath  := ParamStr(0);
  FUpdateApp := StringReplace(FFilePath, ExtractFileName(ParamStr(0)), cUpdateAppName, [rfReplaceAll]);
  if not FileExists(FUpdateApp) then
  begin
    GetUpdateApp;
  end;
  StartNewProcess(UpdateApp, Format('%s %s %s %s', [UpdateApp, cRepoName, ExtractFileName(FFilePath), cVersion]), True);
{$ENDIF}
  Config := TConfig.Create;

  FFunctionPages := TObjectList<TFormPageMaster>.Create(True);
  FFunctionPages.AddRange(CreatePages);
  for i := 0 to FFunctionPages.Count - 1 do
  begin
    FFunctionPages[i].ManualDock(pgcMain);
    FFunctionPages[i].Show;
  end;
  DoResize;
  Application.Name      := StringReplace(Caption, ' ', '', [rfReplaceAll]);
  mpAlwaysOnTop.Checked := Config.AlwaysOnTop;
  cbxZoomUsers.Checked  := Config.CheckZoomUsers;
end;

procedure TFormCongregationHelper.FormDestroy(Sender: TObject);
begin
  Config.Free;
  FFunctionPages.Free;
end;

procedure TFormCongregationHelper.FormShow(Sender: TObject);
begin
  DoResize;
  // AddFunctionPages;
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
  GetLastRelease(LResponse, ExtractFileName(UpdateApp), FUpdateAppUrl, LReleaseResult);
  if LReleaseResult then
  begin
    if not DownloadRelease(UpdateAppUrl) then
      Exit;
  end;
end;

procedure TFormCongregationHelper.mpAlwaysOnTopClick(Sender: TObject);
begin
  mpAlwaysOnTop.Checked := not mpAlwaysOnTop.Checked;
  Config.AlwaysOnTop    := mpAlwaysOnTop.Checked;
  if mpAlwaysOnTop.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

procedure TFormCongregationHelper.mpProgramClick(Sender: TObject);
begin
  if (Sender as TMenuItem).Name = mpHelp.Name then
  begin
    OpenURLInDefaultBrowser('https://github.com/photomax2202/CongregationHelper/wiki');
  end
  else if (Sender as TMenuItem).Name = mpInfo.Name then
  begin
    ShowMessage(Caption + #10#13 + 'Version ' + cVersion + #10#13 + 'GitHub-Repo: ' + cRepoName);
  end
  else if (Sender as TMenuItem).Name = mpExit.Name then
  begin
    Application.Terminate;
  end;
end;

procedure TFormCongregationHelper.mpSettingsClick(Sender: TObject);
begin
  if (Sender as TMenuItem).Name = mpSettingsCamera.Name then
  begin
    FormConfigCamera := TFormConfigCamera.Create(FormCongregationHelper);
    try
      FormConfigCamera.ShowModal;
    finally
      FormConfigCamera.Free;
    end;
  end
  else if (Sender as TMenuItem).Name = mpSettingsMonitor.Name then
  begin
    FormConfigMonitor := TFormConfigMonitor.Create(FormCongregationHelper);
    try
      FormConfigMonitor.ShowModal;
    finally
      FormConfigMonitor.Free;
    end;
  end;
  pgcMain.OnChange(Self);
  DoResize;
end;

procedure TFormCongregationHelper.pgcMainChange(Sender: TObject);
begin
  if Assigned(FunctionPage) then
  begin
    FunctionPage.FormShow(FunctionPage);
  end;
end;

procedure TFormCongregationHelper.SetZoomUserState(Sender: TObject; AState: TZoomUserState);
begin
  if not(Sender is TPanel) then
    Exit;
  if AState = stInactive then
    (Sender as TPanel).Color := clGrayText
  else if AState = stOnline then
    (Sender as TPanel).Color := clLime
  else if AState = stOffline then
    (Sender as TPanel).Color := clRed;
end;

procedure TFormCongregationHelper.tmrZoomUserTimer(Sender: TObject);
begin
  // TimeBase 5000ms
  if not cbxZoomUsers.Checked and FZoomUserCheck then
  begin
    FZoomUserCheck := False;
    SetZoomUserState(pnlZoomUserStage, stInactive);
    SetZoomUserState(pnlZoomUserConference, stInactive);
  end;
  if ((FTimerIndex mod 6) = 0) then
    If FZoomUserCheck then
      CheckZoomUsers;
  if ((FTimerIndex mod 2) = 0) then
    FunctionPage.DoPageTimer;
  Inc(FTimerIndex);
  if FTimerIndex >= 12 then
    FTimerIndex := 0;
end;

end.
