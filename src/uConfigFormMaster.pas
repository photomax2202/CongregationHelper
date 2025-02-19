unit uConfigFormMaster;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  uConfig;

type
  TForrmConfigMaster = class(TForm)
    pnlButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    { Private-Deklarationen }
    FConfig: TConfig;
    procedure StyleReturnButtons;

  protected
    procedure DoFormLoad; virtual; abstract;
    procedure DoFormShow; virtual; abstract;
    procedure DoFormSave(out ACanSave: Boolean); virtual; abstract;
    property Config: TConfig
      read   FConfig;
  public
    { Public-Deklarationen }
  end;

implementation

uses
  Math,
  uCongregationHelper;

{$R *.dfm}

procedure TForrmConfigMaster.btnOkClick(Sender: TObject);
var
  LCanSave: Boolean;
begin
  DoFormSave(LCanSave);
  if not LCanSave then
    ModalResult := mrNone;
end;

procedure TForrmConfigMaster.FormCreate(Sender: TObject);
begin
  FConfig := FormCongregationHelper.Config;
  DoFormLoad;
  StyleReturnButtons;
end;

procedure TForrmConfigMaster.FormShow(Sender: TObject);
begin
  DoFormShow;
  if Config.AlwaysOnTop then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

procedure TForrmConfigMaster.StyleReturnButtons;
begin
  btnOk.Top      := Ceil((pnlButtons.Height - btnOk.Height) / 2);
  btnOk.Left     := Ceil(pnlButtons.Width / 2 + 8);
  btnCancel.Top  := Ceil((pnlButtons.Height - btnCancel.Height) / 2);
  btnCancel.Left := Ceil(pnlButtons.Width / 2 - 8 - btnCancel.Width);
end;

end.
