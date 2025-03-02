unit uConfigZoom;

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
  TFormConfigZoom = class(TForrmConfigMaster)
  private
    { Private-Deklarationen }
    procedure DoFormLoad; override;
    procedure DoFormShow; override;
    procedure DoFormSave(out ACanSave: Boolean); override;
  public
    { Public-Deklarationen }
  end;

var
  FormConfigZoom: TFormConfigZoom;

implementation

uses
  uCongregationHelper,
  uValidationAndHelper,
  System.NetEncoding;

{$R *.dfm}


procedure TFormConfigZoom.DoFormLoad;
begin
  inherited;
  //
end;

procedure TFormConfigZoom.DoFormSave(out ACanSave: Boolean);
begin
  inherited;
  ACanSave := True;
  //
end;

procedure TFormConfigZoom.DoFormShow;
begin
  inherited;
end;


end.
