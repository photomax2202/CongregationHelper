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
  private
    procedure DoPageCreate; override;
    procedure DoPageShow; override;
    procedure DoPageClose; override;
  protected
  public

  end;

var
  FormPageFunctionSample: TFormPageFunctionSample;

implementation

{$R *.dfm}
{ TFormPageFunctionSample }

procedure TFormPageFunctionSample.DoPageClose;
begin
  inherited;
  //
end;

procedure TFormPageFunctionSample.DoPageCreate;
begin
  inherited;
  PageName := 'Sample';
end;

procedure TFormPageFunctionSample.DoPageShow;
begin
  inherited;
  //
end;

end.
