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
    procedure ledProgramNameChange(Sender: TObject);
    procedure cbxProgramCaptionChange(Sender: TObject);
    procedure cbxProgramModeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FProgramName   : String;
    FProgramCaption: String;
    FProgramMode   : String;
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
    property ProgramMode: String
      read   FProgramMode;
  end;

function EnumWindowsProc(Wnd: HWND; lParam: lParam): BOOL; stdcall;
function GetWindowEntry(out AName: String; out ACaption: string; out AMode: String): TModalResult;

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

function GetWindowEntry(out AName: String; out ACaption: string; out AMode: String): TModalResult;
begin
  FormProgramAdd := TFormProgrammAdd.Create(nil);
  try
    FormProgramAdd.WindowList.Items.Clear;
    EnumWindows(@EnumWindowsProc, 0);
    FormProgramAdd.BringToFront;
    FormProgramAdd.FormStyle := fsStayOnTop;
    Result   := FormProgramAdd.ShowModal;
    AName    := FormProgramAdd.ProgramName;
    ACaption := FormProgramAdd.ProgramCaption;
    AMode    := FormProgramAdd.ProgramMode;
  finally
    FormProgramAdd.Free;
  end;
end;

{ TFormProgrammAdd }

procedure TFormProgrammAdd.cbxProgramCaptionChange(Sender: TObject);
begin
  FProgramCaption := cbxProgramCaption.Items[cbxProgramCaption.ItemIndex];
end;

procedure TFormProgrammAdd.cbxProgramModeChange(Sender: TObject);
begin
  FProgramMode := cbxProgramMode.Items[cbxProgramMode.ItemIndex];
end;

procedure TFormProgrammAdd.FormShow(Sender: TObject);
begin
  cbxProgramMode.OnChange(Self);
end;

procedure TFormProgrammAdd.ledProgramNameChange(Sender: TObject);
begin
  FProgramName := ledProgramName.Text;
end;

end.
