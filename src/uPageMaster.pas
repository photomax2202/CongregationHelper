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
    procedure FormCreate(Sender: TObject);
  private
    FPageName: String;
    function GetMaxWidth: Integer;
    function GetMaxHeight: Integer;
    function GetPageName: String;
    { Private-Deklarationen }
  protected
    procedure InitPage; virtual; abstract;

  public
    { Public-Deklarationen }
    property MaxWidth: Integer
      read   GetMaxWidth;
    property MaxHeight: Integer
      read   GetMaxHeight;
    property PageName: String
      read   GetPageName
      write  FPageName;

  end;

implementation

{$R *.dfm}
{ TFormPageMaster }

procedure TFormPageMaster.FormCreate(Sender: TObject);
begin
  InitPage;
end;

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

function TFormPageMaster.GetPageName: String;
begin
  if Length(FPageName) > 0 then
    Result := FPageName
  else
    Result := Caption;
end;

end.
