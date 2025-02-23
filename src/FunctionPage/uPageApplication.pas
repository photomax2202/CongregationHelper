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
    FMaxPanelHeight        : Integer;
    procedure DoPageCreate; override;
    procedure DoPageShow; override;
    procedure DoPageClose; override;
    procedure FillForm;
    procedure LoadApplicationList;
    function CompareApplicationList(AList1: TList<TApplicationEntry>; AList2: TList<TApplicationEntry>): Boolean;
    procedure BuildButtons(APanel: TPanel);
    procedure DeleteButtons(APanel: TPanel);
    procedure OnButtonClick(Sender: TObject);
    property MaxPanelHeight: Integer
      read   FMaxPanelHeight;
  protected
  public
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
  LHeight     : Integer;
begin
  if APanel.Name = pnlBtnLeft.Name then
    LMode := cDropLeft
  else if APanel.Name = pnlBtnRight.Name then
    LMode := cDropRight
  else if APanel.Name = pnlBtnPresentation.Name then
    LMode := cDropPresentation
  else
    Exit;
  DeleteButtons(APanel);
  LButtonCount := 0;
  for i        := 0 to FApplicationList.Count - 1 do
  begin
    if FApplicationList[i].Mode = LMode then
    begin;
      Inc(LButtonCount);
      LNewButton                 := TButton.Create(APanel);
      LNewButton.Parent          := APanel;
      LNewButton.Left            := 8;
      LNewButton.Width           := 120;
      LNewButton.Top             := 8 + 15 + 8 + ((LButtonCount - 1) * (LNewButton.Height + 8));
      LNewButton.Caption         := FApplicationList[i].Name;
      LNewButton.Hint            := FApplicationList[i].Caption;
      LNewButton.CommandLinkHint := FApplicationList[i].Mode;
      LNewButton.OnClick         := OnButtonClick;
      LHeight                    := LNewButton.Top + LNewButton.Height + 16;
      if FMaxPanelHeight < LHeight then
        FMaxPanelHeight := LHeight;
    end;
  end;
end;

procedure TFormPageApplication.LoadApplicationList;
var
  i: Integer;
begin
  FApplicationListNext.Clear;
  for i := 0 to Config.ApplicationCount - 1 do
  begin
    FApplicationListNext.Add(Config.GetApplicationEntry(i));
  end;
  FUpdatedApplicationList := CompareApplicationList(FApplicationList, FApplicationListNext);
  FApplicationList.Clear;
  for i := 0 to Config.ApplicationCount - 1 do
  begin
    FApplicationList.Add(Config.GetApplicationEntry(i));
  end;
end;

procedure TFormPageApplication.OnButtonClick(Sender: TObject);
begin
  ShowMessage((Sender as TButton).Caption);
end;

function TFormPageApplication.CompareApplicationList(AList1, AList2: TList<TApplicationEntry>): Boolean;
var
  i: Integer;
begin
  Result := True;
  if AList1.Count <> AList2.Count then
    Exit;
  for i := 0 to AList1.Count - 1 do
  begin
    if AList1[i].Name <> AList2[i].Name then
      Exit;
    if AList1[i].Caption <> AList2[i].Caption then
      Exit;
    if AList1[i].Mode <> AList2[i].Mode then
      Exit;
  end;
  Result := False;
end;

procedure TFormPageApplication.DeleteButtons(APanel: TPanel);
var
  i       : Integer;
begin
  for i := APanel.ControlCount - 1 downto 0 do
  begin
    if APanel.Controls[i] is TButton then
      APanel.Controls[i].Free;
  end;
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
  FillForm;
end;

procedure TFormPageApplication.DoPageShow;
begin
  inherited;
  FillForm;
end;

procedure TFormPageApplication.FillForm;
begin
  LoadApplicationList;
  if FUpdatedApplicationList then
  begin
    FMaxPanelHeight := 0;
    BuildButtons(pnlBtnLeft);
    BuildButtons(pnlBtnRight);
    BuildButtons(pnlBtnPresentation);
    pnlBtnLeft.Height := MaxPanelHeight;
    pnlBtnRight.Height := MaxPanelHeight;
    pnlBtnPresentation.Height := MaxPanelHeight;
    Height := Height - pnlBtnLeft.Height + MaxPanelHeight;
  end;
end;

end.
