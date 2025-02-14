unit uPageMaster;

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
  Vcl.StdCtrls;

type
  TFormPageMaster = class(TForm)
  private
    function GetMaxWidth: Integer;
    function GetMaxHeight: Integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    property MaxWidth: Integer
      read   GetMaxWidth;
    property MaxHeight: Integer
      read   GetMaxHeight;

  end;

implementation

{$R *.dfm}
{ TFormPageMaster }

function TFormPageMaster.GetMaxHeight: Integer;
var
  i      : Integer;
  LHeight: Integer;
begin
  Result := 0;
  for i  := 0 to ControlCount - 1 do
  begin
    LHeight := Controls[i].Top + Controls[i].Height;
    if LHeight > Result then
      Result := LHeight;
  end;
  Result := Result + 16;
end;

function TFormPageMaster.GetMaxWidth: Integer;
var
  i     : Integer;
  LWidth: Integer;
begin
  Result := 0;
  for i  := 0 to ControlCount - 1 do
  begin
    LWidth := Controls[i].Left + Controls[i].Width;
    if LWidth > Result then
      Result := LWidth;
  end;
  Result := Result + 16;
end;

end.
