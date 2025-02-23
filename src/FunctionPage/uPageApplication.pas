unit uPageApplication;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  uPageMaster,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  uConfig;

type
  TFormPageApplication = class(TFormPageMaster)
    pnlBtnLeft: TPanel;
    pnlBtnRight: TPanel;
    pnlBtnPresentation: TPanel;
    lblBtnLeft: TLabel;
    lblBtnRight: TLabel;
    lblBtnPresentation: TLabel;
  private
    FApplicationList       : TList<TApplicationEntry>;
    FApplicationListNext   : TList<TApplicationEntry>;
    FUpdatedApplicationList: Boolean;
    procedure DoPageCreate; override;
    procedure DoPageShow; override;
    procedure DoPageClose; override;
    procedure LoadApplicationList;
    procedure BuildButtons(APanel: TPanel);
    procedure OnButtonClick(Sender: TObject);
  protected
  public
    procedure TestProcedure; override;
  end;

const
  cDropLeft         = 'Links Anheften';
  cDropRight        = 'Rechts Anheften';
  cDropPresentation = 'Präsentation';

var
  FormPageApplication: TFormPageApplication;

implementation

{$R *.dfm}
{ TFormPageApplication }

procedure TFormPageApplication.BuildButtons(APanel: TPanel);
var
  i           : Integer;
  LButtonCount: Integer;
  LMode       : string;
  LNewButton  : TButton;
begin
  if APanel.Name = pnlBtnLeft.Name then
    LMode := cDropLeft
  else if APanel.Name = pnlBtnRight.Name then
    LMode := cDropRight
  else if APanel.Name = pnlBtnPresentation.Name then
    LMode := cDropPresentation
  else
    Exit;
  LButtonCount := 0;
  for i        := 0 to FApplicationList.Count - 1 do
  begin
    if FApplicationList[i].Mode = LMode then
    begin;
      Inc(LButtonCount);
      LNewButton := TButton.Create(APanel);
      try
        LNewButton.Parent          := APanel;
        LNewButton.Left            := 10;
        LNewButton.Width           := 140;
        LNewButton.Top             := 8 + 15 + 8 + ((LButtonCount - 1) * (LNewButton.Height + 8));
        LNewButton.Caption         := FApplicationList[i].Name;
        LNewButton.Hint            := FApplicationList[i].Caption;
        LNewButton.CommandLinkHint := FApplicationList[i].Mode;
        LNewButton.OnClick         := OnButtonClick;
      finally
        LNewButton.Free;
      end;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TFormPageApplication.LoadApplicationList;
var
  i: Integer;
begin
  for i := 0 to Config.ApplicationCount - 1 do
  begin
    FApplicationListNext.Add(Config.GetApplicationEntry(i));
  end;
  FUpdatedApplicationList := not(FApplicationList = FApplicationListNext);
  for i                   := 0 to Config.ApplicationCount - 1 do
  begin
    FApplicationList.Add(Config.GetApplicationEntry(i));
  end;
end;

procedure TFormPageApplication.OnButtonClick(Sender: TObject);
begin
  ShowMessage((Sender as TButton).Caption);
end;

procedure TFormPageApplication.DoPageClose;
begin
  inherited;
  FApplicationList.Free;
  FApplicationListNext.Free;
end;

procedure TFormPageApplication.DoPageCreate;
begin
  inherited;
  PageName             := 'Programme';
  FApplicationList     := TList<TApplicationEntry>.Create;
  FApplicationListNext := TList<TApplicationEntry>.Create;
end;

procedure TFormPageApplication.DoPageShow;
begin
  inherited;
  LoadApplicationList;
  if FUpdatedApplicationList then
  begin
    BuildButtons(pnlBtnLeft);
    BuildButtons(pnlBtnRight);
    BuildButtons(pnlBtnPresentation);
  end;
end;

procedure TFormPageApplication.TestProcedure;
begin
  inherited;
  ShowMessage('Testnachicht: ' + Caption);
end;

end.
