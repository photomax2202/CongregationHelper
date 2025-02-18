unit uProgramList;

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
  Vcl.ExtCtrls;

type
  TProgramList = class(TListBox)
  private
  protected
  public
    procedure MoveEntryUp;
    procedure MoveEntryDown;
    procedure MoveEntryTop;
    procedure MoveEntryBottom;
    procedure AddEntry;
    procedure DeleteEntry;
  end;

  TFormProgrammAdd = class(TForm)
    ledProgramName: TLabeledEdit;
    cbxProgramCaption: TComboBox;
    lblProgramCaption: TLabel;
    btnCancel: TButton;
    btnOk: TButton;
    procedure ledProgramNameChange(Sender: TObject);
    procedure cbxProgramCaptionChange(Sender: TObject);
  private
    FProgramName   : String;
    FProgramCaption: String;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    property WindowList: TComboBox
      read   cbxProgramCaption
      write  cbxProgramCaption;
    property ProgramName: String
      read   FProgramName;
    property ProgramCaption: String
      read   FProgramCaption;
  end;

function EnumWindowsProc(Wnd: HWND; lParam: lParam): BOOL; stdcall;
function GetWindowEntry(out AName: String;out ACaption: string): TModalResult;

var
  FormProgramAdd: TFormProgrammAdd;

implementation

{$R *.dfm}

function EnumWindowsProc(Wnd: HWND; lParam: lParam): BOOL; stdcall;
var
  Title  : array [0 .. 255] of Char;
  ExStyle: Longint;
begin
  ExStyle := GetWindowLong(Wnd, GWL_EXSTYLE);
  if IsWindow(Wnd) and IsWindowVisible(Wnd) { and ((ExStyle and WS_EX_APPWINDOW) = WS_EX_APPWINDOW) } then
  begin
    GetWindowText(Wnd, Title, Length(Title));
    if StrLen(Title) > 0 then
      FormProgramAdd.WindowList.Items.Add(Title);
  end;
  Result := True;
end;

function GetWindowEntry(out AName: String;out ACaption: string): TModalResult;
begin
  FormProgramAdd := TFormProgrammAdd.Create(nil);
  try
    FormProgramAdd.WindowList.Items.Clear;
    EnumWindows(@EnumWindowsProc, 0);
    Result   := FormProgramAdd.ShowModal;
    AName    := FormProgramAdd.ProgramName;
    ACaption := FormProgramAdd.ProgramCaption;
  finally
    FormProgramAdd.Free;
  end;
end;

{ TProgramList }

procedure TProgramList.AddEntry;
var
  LName, LCaption: String;
begin
  if GetWindowEntry(LName, LCaption) <> mrOk then
    Exit;
  Items.Add(Format('Name=%s;Caption=%s',[LName,LCaption]));
end;

procedure TProgramList.DeleteEntry;
begin
Items.Delete(ItemIndex);
end;

procedure TProgramList.MoveEntryBottom;
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  SelectedIndex := ItemIndex;
  if (SelectedIndex > 0) and (SelectedIndex < Items.Count) then
  begin
    SelectedText := Items[SelectedIndex];
    Items.Delete(SelectedIndex);
    Items.Insert(Count - 1, SelectedText);
    ItemIndex := Count - 1;
  end;
end;

procedure TProgramList.MoveEntryDown;
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  SelectedIndex := ItemIndex;
  if (SelectedIndex > 0) and (SelectedIndex < Items.Count) then
  begin
    SelectedText := Items[SelectedIndex];
    Items.Delete(SelectedIndex);
    Items.Insert(SelectedIndex + 1, SelectedText);
    ItemIndex := SelectedIndex + 1;
  end;
end;

procedure TProgramList.MoveEntryTop;
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  SelectedIndex := ItemIndex;
  if (SelectedIndex > 0) and (SelectedIndex < Items.Count) then
  begin
    SelectedText := Items[SelectedIndex];
    Items.Delete(SelectedIndex);
    Items.Insert(0, SelectedText);
    ItemIndex := 0;
  end;
end;

procedure TProgramList.MoveEntryUp;
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  SelectedIndex := ItemIndex;
  if (SelectedIndex > 0) and (SelectedIndex < Items.Count) then
  begin
    SelectedText := Items[SelectedIndex];
    Items.Delete(SelectedIndex);
    Items.Insert(SelectedIndex - 1, SelectedText);
    ItemIndex := SelectedIndex - 1;
  end;
end;

{ TFormProgrammAdd }

procedure TFormProgrammAdd.cbxProgramCaptionChange(Sender: TObject);
begin
  FProgramCaption := cbxProgramCaption.Items[cbxProgramCaption.ItemIndex];
end;

procedure TFormProgrammAdd.ledProgramNameChange(Sender: TObject);
begin
  FProgramName := ledProgramName.Text;
end;

end.
