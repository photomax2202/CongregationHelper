unit uCongregationHelper;

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
  Vcl.Menus,
  uConfig,
  Vcl.ComCtrls,
  uPageMaster,
  uGitHub;

type
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
    procedure mpAlwaysOnTopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mpSettingsClick(Sender: TObject);
    procedure mpProgramClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FConfig      : TConfig;
    FUpdateApp   : String;
    FFilePath    : String;
    FUpdateAppUrl: String;
    { Private-Deklarationen }
    procedure AddFunctionPages;
    function GetFunctionPages(i: Integer): TFormPageMaster;
    function GetFunctionPage: TFormPageMaster;
    procedure GetUpdateApp;
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
  end;

const
  cVersion = 'v0.0.1_alpha';
  cRepoName= 'CongregationHelper';
  cUpdateAppName = 'AutoUpdater.exe';

var
  FormCongregationHelper: TFormCongregationHelper;

implementation

uses
  StrUtils,
  uConfigCamera,
  uConfigMonitor,
  uPageFunctionSample;

{$R *.dfm}

procedure TFormCongregationHelper.AddFunctionPages;

  procedure AddFunctionPage(AForm: TForm);
  begin
    AForm.ManualDock(pgcMain);
    AForm.Show;
  end;

var
  i             : Integer;
  LHight, LWidth: Integer;
begin
{$IFDEF DEBUG}
  AddFunctionPage(FormPageFunctionSample);
{$ENDIF}
  LWidth := 0;
  LHight := 0;
  for i  := 0 to pgcMain.PageCount - 1 do
  begin
    if FunctionPages[i].MaxWidth > LWidth then
      LWidth := FunctionPages[i].MaxWidth;
    if FunctionPages[i].MaxHeight > LHight then
      LHight := FunctionPages[i].MaxHeight;
  end;
  Constraints.MinWidth  := 0;
  Constraints.MaxWidth  := 0;
  Constraints.MinHeight := 0;
  Constraints.MaxHeight := 0;
  Width                 := Width - pgcMain.Width + LWidth;
//   Constraints.MinWidth  := Width;
//   Constraints.MaxWidth  := Width;
  Height := Height - pgcMain.Height + LHight;
//   Constraints.MinHeight := Height;
//   Constraints.MaxHeight := Height;
end;

procedure TFormCongregationHelper.FormCreate(Sender: TObject);
var
  LReleasesText: string;
  LRespose     : string;
begin

{$IFNDEF DEBUG}
  FFilePath  := ParamStr(0);
  FUpdateApp := StringReplace(FFilePath, ExtractFileName(ParamStr(0)), cUpdateAppName, [rfReplaceAll]);
  if not FileExists(FUpdateApp) then
  begin
    GetUpdateApp;
  end;
  StartNewProcess(UpdateApp,Format('%s %s %s %s',[UpdateApp, cRepoName,  ExtractFileName(FFilePath), cVersion]),True);
{$ENDIF}
  Config                := TConfig.Create;
  Application.Name      := StringReplace(Caption, ' ', '', [rfReplaceAll]);
  mpAlwaysOnTop.Checked := Config.AlwaysOnTop;
end;

procedure TFormCongregationHelper.FormDestroy(Sender: TObject);
begin
  Config.Free;
end;

procedure TFormCongregationHelper.FormShow(Sender: TObject);
begin
  AddFunctionPages;
end;

function TFormCongregationHelper.GetFunctionPage: TFormPageMaster;
begin
  Result := TFormPageMaster(pgcMain.ActivePage);
end;

function TFormCongregationHelper.GetFunctionPages(i: Integer): TFormPageMaster;
begin
  Result := TFormPageMaster(pgcMain.Pages[i]);
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
  OpenURLInDefaultBrowser('https://github.com/photomax2202/CongregationHelper');
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
    FormConfigCamera.ShowModal
  end
  else if (Sender as TMenuItem).Name = mpSettingsMonitor.Name then
  begin
    FormConfigMonitor.ShowModal;
  end;

end;

end.
