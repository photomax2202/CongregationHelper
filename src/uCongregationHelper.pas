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
  uConfig;

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
    procedure mpAlwaysOnTopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mpSettingsCameraClick(Sender: TObject);
    procedure mpBeendenClick(Sender: TObject);
    procedure mpMonitorSettingsClick(Sender: TObject);
  private
    FConfig: TConfig;
    { Private-Deklarationen }
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
uConfigCamera, uConfigMonitor;

{$R *.dfm}

procedure TFormCongregationHelper.FormCreate(Sender: TObject);
begin
  Config                := TConfig.Create;
  Application.Name      := StringReplace(Caption, ' ', '', [rfReplaceAll]);
  mpAlwaysOnTop.Checked := Config.AlwaysOnTop;
end;

procedure TFormCongregationHelper.FormDestroy(Sender: TObject);
begin
  Config.Free;
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
