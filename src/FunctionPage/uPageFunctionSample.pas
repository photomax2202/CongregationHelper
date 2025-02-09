unit uPageFunctionSample;

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
  uPageMaster,
  Vcl.StdCtrls;

type
  TFormPageFunctionSample = class(TFormPageMaster)
    Button1: TButton;
  private
    { Private-Deklarationen }
  protected
    procedure InitPage; override;
  public
    { Public-Deklarationen }

  end;

var
  FormPageFunctionSample: TFormPageFunctionSample;

implementation

{$R *.dfm}
{ TFormPageFunctionSample }

procedure TFormPageFunctionSample.InitPage;
begin
  inherited;
  PageName := 'Sample';
end;

end.
