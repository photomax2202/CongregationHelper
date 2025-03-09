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

  TFormProgrammAdd = class(TForm)
    ledProgramName: TLabeledEdit;
    cbxProgramCaption: TComboBox;
    lblProgramCaption: TLabel;
    btnCancel: TButton;
    btnOk: TButton;
    lblProgrammMode: TLabel;
    cbxProgramMode: TComboBox;
    ledProgrammClass: TLabeledEdit;
    procedure ledProgramNameChange(Sender: TObject);
    procedure cbxProgramCaptionChange(Sender: TObject);
    procedure cbxProgramModeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ledProgrammClassChange(Sender: TObject);
  private
    FProgramName     : String;
    FProgramCaption  : String;
    FProgramMode     : String;
    FProgramClass    : string;
    FProgramClassList: TStringList;

  public
    property WindowList: TComboBox
      read   cbxProgramCaption
      write  cbxProgramCaption;
    property ProgramClassList: TStringList
      read   FProgramClassList
      write  FProgramClassList;
    property ProgramName: String
      read   FProgramName;
    property ProgramCaption: String
      read   FProgramCaption;
    property ProgramMode: String
      read   FProgramMode;
    property ProgramClass: String
      read   FProgramClass;
    procedure SortList;
  end;

function EnumWindowsProc(Wnd: HWND; lParam: lParam): BOOL; stdcall;
function GetWindowEntry(out AName: String; out ACaption: string; out AClass: string; out AMode: String): TModalResult;

var
  FormProgramAdd: TFormProgrammAdd;

implementation

{$R *.dfm}

function EnumWindowsProc(Wnd: HWND; lParam: lParam): BOOL; stdcall;
var
  Title                   : array [0 .. 255] of Char;
  ClassName               : array [0 .. 255] of Char;
  StringTitle, StringClass: String;
  ExStyle                 : Longint;
begin
  ExStyle := GetWindowLong(Wnd, GWL_EXSTYLE);
  GetWindowText(Wnd, Title, Length(Title));
  GetClassName(Wnd, ClassName, Length(ClassName));
  if StrLen(Title) > 0 then
  begin
    SetString(StringTitle, Title, StrLen(Title));
    SetString(StringClass, ClassName, StrLen(ClassName));
  end;
  if IsWindow(Wnd) and IsWindowVisible(Wnd) { and ((ExStyle and WS_EX_APPWINDOW) = WS_EX_APPWINDOW) } then
  begin
    if StrLen(Title) > 0 then
    begin
      FormProgramAdd.WindowList.Items.Add(StringTitle);
      FormProgramAdd.ProgramClassList.Add(StringClass);
    end;
  end;
  Result := True;
end;

function GetWindowEntry(out AName: String; out ACaption: string; out AClass: string; out AMode: String): TModalResult;
begin
  FormProgramAdd := TFormProgrammAdd.Create(nil);
  try
    FormProgramAdd.WindowList.Items.Clear;
    EnumWindows(@EnumWindowsProc, 0);
    FormProgramAdd.SortList;
    FormProgramAdd.BringToFront;
    FormProgramAdd.FormStyle := fsStayOnTop;
    Result                   := FormProgramAdd.ShowModal;
    AName                    := FormProgramAdd.ProgramName;
    ACaption                 := FormProgramAdd.ProgramCaption;
    AClass                   := FormProgramAdd.ProgramClass;
    AMode                    := FormProgramAdd.ProgramMode;
  finally
    FormProgramAdd.Free;
  end;
end;

{ TFormProgrammAdd }

procedure TFormProgrammAdd.cbxProgramCaptionChange(Sender: TObject);
begin
  FProgramCaption       := cbxProgramCaption.Items[cbxProgramCaption.ItemIndex];
  ledProgrammClass.Text := FProgramClassList.Strings[cbxProgramCaption.ItemIndex];
end;

procedure TFormProgrammAdd.cbxProgramModeChange(Sender: TObject);
begin
  FProgramMode := cbxProgramMode.Items[cbxProgramMode.ItemIndex];
end;

procedure TFormProgrammAdd.FormCreate(Sender: TObject);
begin
  FProgramClassList := TStringList.Create;
end;

procedure TFormProgrammAdd.FormDestroy(Sender: TObject);
begin
  FProgramClassList.Free;
end;

procedure TFormProgrammAdd.FormShow(Sender: TObject);
begin
  cbxProgramMode.OnChange(Self);
end;

procedure TFormProgrammAdd.ledProgrammClassChange(Sender: TObject);
begin
  FProgramClass := ledProgrammClass.Text;
end;

procedure TFormProgrammAdd.ledProgramNameChange(Sender: TObject);
begin
  FProgramName := ledProgramName.Text;
end;

procedure TFormProgrammAdd.SortList;
var
  LComboBoxList, LClassList: TStringList;
  i                        : Integer;
begin
  LComboBoxList := TStringList.Create;
  LClassList    := TStringList.Create;
  try
    for i := 0 to cbxProgramCaption.Items.Count - 1 do
    begin
      cbxProgramCaption.Items[i] := cbxProgramCaption.Items[i] + '---' + i.ToString;
    end;
    LComboBoxList.Assign(cbxProgramCaption.Items);
    LComboBoxList.Sort;
    for i := 0 to LComboBoxList.Count - 1 do
    begin
      LClassList.Add(FProgramClassList[cbxProgramCaption.Items.IndexOf(LComboBoxList[i])]);
    end;
    for i := 0 to LComboBoxList.Count - 1 do
    begin
      LComboBoxList[i] := Copy(LComboBoxList[i],0,Pos('---',LComboBoxList[i])-1)
    end;
    cbxProgramCaption.Items.Clear;
    FProgramClassList.Clear;
    cbxProgramCaption.Items.Assign(LComboBoxList);
    FProgramClassList.Assign(LClassList);
    cbxProgramCaption.ItemIndex := 0;
    cbxProgramCaption.OnChange(Self);
  finally
    LComboBoxList.Free;
    LClassList.Free;
  end;

end;

end.
