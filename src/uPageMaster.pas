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
  Vcl.StdCtrls,
  uConfig;

type
  TFormPageMaster = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FPageName: String;
    FConfig  : TConfig;
    function GetMaxWidth: Integer;
    function GetMaxHeight: Integer;
    function GetPageName: String;
  protected
    procedure DoPageCreate; virtual; abstract;
    procedure DoPageShow; virtual; abstract;
    procedure DoPageClose; virtual; abstract;
    procedure TestProcedure; virtual; abstract;
  public
    property MaxWidth: Integer
      read   GetMaxWidth;
    property MaxHeight: Integer
      read   GetMaxHeight;
    property PageName: String
      read   GetPageName
      write  FPageName;
    property Config: TConfig
      read   FConfig;
  end;

implementation

uses
  uCongregationHelper;

{$R *.dfm}
{ TFormPageMaster }

procedure TFormPageMaster.FormCreate(Sender: TObject);
begin
  FConfig := FormCongregationHelper.Config;
  DoPageCreate;
  Caption := PageName;
end;

procedure TFormPageMaster.FormDestroy(Sender: TObject);
begin
  DoPageClose;
end;

procedure TFormPageMaster.FormShow(Sender: TObject);
begin
  DoPageShow;
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
