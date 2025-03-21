unit uConfigGeneral;

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
  uConfig,
  uConfigFormMaster;

type
  TFormConfigGeneral = class(TForrmConfigMaster)
    ledUrlCheckliste: TLabeledEdit;
    procedure ledFieldValidation(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure DoFormLoad; override;
    procedure DoFormShow; override;
    procedure DoFormSave(out ACanSave: Boolean); override;
  public
    { Public-Deklarationen }
  end;

var
  FormConfigGeneral: TFormConfigGeneral;

implementation

uses
  uCongregationHelper,
  uValidationAndHelper,
  System.NetEncoding;

{$R *.dfm}

procedure TFormConfigGeneral.DoFormLoad;
begin
  inherited;
  //
end;

procedure TFormConfigGeneral.DoFormSave(out ACanSave: Boolean);
begin
  inherited;
  ACanSave := False;
  if not ValidateWebAdress(ledUrlCheckliste.Text) then
    Exit;

  Config.UrlChecklist := ledUrlCheckliste.Text;

  ACanSave := True;
end;

procedure TFormConfigGeneral.DoFormShow;
begin
  inherited;
  ledUrlCheckliste.Text := Config.UrlChecklist;
end;

procedure TFormConfigGeneral.ledFieldValidation(Sender: TObject);
var
  LName: String;
  LText: string;
begin
  inherited;
  LName := (Sender as TLabeledEdit).Name;
  LText := (Sender as TLabeledEdit).Text;
  if LName = ledUrlCheckliste.Name then
    MarkValidation(ledUrlCheckliste, ValidateWebAdress(LText));
end;

end.
