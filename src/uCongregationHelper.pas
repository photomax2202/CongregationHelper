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
  Vcl.ComCtrls;

type
  TFormCongregationHelper = class(TForm)
    mpMainMenu: TMainMenu;
    mpSettings: TMenuItem;
    mpAlwaysOnTop: TMenuItem;
    mpSettingsCamera: TMenuItem;
    mpProgramm: TMenuItem;
    mpBeenden: TMenuItem;
    mpInfo: TMenuItem;
    mpMonitorSettings: TMenuItem;
    pgcMain: TPageControl;
    procedure mpAlwaysOnTopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mpSettingsCameraClick(Sender: TObject);
    procedure mpBeendenClick(Sender: TObject);
    procedure mpMonitorSettingsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FConfig: TConfig;
    { Private-Deklarationen }
    procedure AddFunctionPages;
  public
    { Public-Deklarationen }
    property Config: TConfig
      read   FConfig
      write  FConfig;
  end;

const
  cVersion = 'v0.0.1_alpha';

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
  end;

var
  i: Integer;
  LHight, LWidth: Integer;
begin
{$IFDEF DEBUG}
  AddFunctionPage(FormPageFunctionSample);
{$ENDIF}

  for i := 0 to pgcMain.PageCount - 1 do
  begin
  {TODO -oMax -cPageControl : Berechnung der Fenstergröße}
     LHight := pgcMain.Pages[i].Width;
  end;
end;

procedure TFormCongregationHelper.FormCreate(Sender: TObject);
begin

{$IFNDEF DEBUG}
  // Update aufruf implementieren
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

procedure TFormCongregationHelper.mpAlwaysOnTopClick(Sender: TObject);
begin
  mpAlwaysOnTop.Checked := not mpAlwaysOnTop.Checked;
  Config.AlwaysOnTop    := mpAlwaysOnTop.Checked;
  if mpAlwaysOnTop.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

procedure TFormCongregationHelper.mpBeendenClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormCongregationHelper.mpMonitorSettingsClick(Sender: TObject);
begin
  FormConfigMonitor.ShowModal;
end;

procedure TFormCongregationHelper.mpSettingsCameraClick(Sender: TObject);
begin
  FormConfigCamera.ShowModal;
end;

end.
