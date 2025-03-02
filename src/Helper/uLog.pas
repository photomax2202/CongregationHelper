unit uLog;

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
  Vcl.Menus;

type
  TFormLog = class(TForm)
    memLog: TMemo;
    mpLog: TPopupMenu;
    mpReset: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mpResetClick(Sender: TObject);
    procedure memLogChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure DoLog(AText: String);

  end;

var
  FormLog: TFormLog;

implementation

{$R *.dfm}

procedure TFormLog.DoLog(AText: String);
begin
  memLog.lines.Add(AText);
end;

procedure TFormLog.FormCreate(Sender: TObject);
begin
  memLog.Clear;
end;

procedure TFormLog.memLogChange(Sender: TObject);
begin
if memLog.Lines.Count > 100 then
memLog.Lines.Delete(0);
end;

procedure TFormLog.mpResetClick(Sender: TObject);
begin
  memLog.Clear;
end;

end.
