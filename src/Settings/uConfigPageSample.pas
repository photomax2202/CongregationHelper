unit uConfigPageSample;

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
  TFormConfigPageSample = class(TForrmConfigMaster)
  private
    { Private-Deklarationen }
    procedure DoFormLoad; override;
    procedure DoFormShow; override;
    procedure DoFormSave(out ACanSave: Boolean); override;
  public
    { Public-Deklarationen }
  end;

var
  FormConfigPageSample: TFormConfigPageSample;

implementation

uses
  uCongregationHelper,
  uValidationAndHelper,
  System.NetEncoding;

{$R *.dfm}


procedure TFormConfigPageSample.DoFormLoad;
begin
  inherited;
  //
end;

procedure TFormConfigPageSample.DoFormSave(out ACanSave: Boolean);
begin
  inherited;
  ACanSave := True;
  //
end;

procedure TFormConfigPageSample.DoFormShow;
begin
  inherited;
end;


end.
