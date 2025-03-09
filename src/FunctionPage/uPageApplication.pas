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
  TButtons = class(TList<TButton>)
  end;

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
    FButtonListLeft        : TButtons;
    FButtonListRight       : TButtons;
    FButtonListPresentation: TButtons;
    FUpdatedApplicationList: Boolean;
    FMaxPanelHeight        : Integer;
    procedure DoPageCreate; override;
    procedure DoPageShow; override;
    procedure DoPageClose; override;
    procedure DoPageTimer; override;
    procedure FillForm;
    procedure LoadApplicationList;
    function CompareApplicationList(AList1: TList<TApplicationEntry>; AList2: TList<TApplicationEntry>): Boolean;
    procedure BuildButtons(AApplicationMode: TApplicationMode; var APanel: TPanel; var AButtons: TButtons);
    procedure DeleteButtons(var AButtons: TButtons);
    procedure EnableButtons(var AButtons: TButtons);
    procedure OnButtonClick(Sender: TObject);
    property MaxPanelHeight: Integer
      read   FMaxPanelHeight;
  protected
  public
  end;

var
  FormPageApplication: TFormPageApplication;

implementation

uses
  uMonitorHandler;

{$R *.dfm}
{ TFormPageApplication }

procedure TFormPageApplication.BuildButtons(AApplicationMode: TApplicationMode; var APanel: TPanel;
  var AButtons: TButtons);

  function AddButton(AApplicationEntry: TApplicationEntry; AButtonCountNow: Integer; var APanel: TPanel): TButton;
  begin
    Result         := TButton.Create(Self);
    Result.Parent  := APanel;
    Result.Top     := 8 + 15 + 8 + ((AButtonCountNow) * (Result.Height + 8));
    Result.Left    := 8;
    Result.Width   := APanel.Width - (Result.Left * 2);
    Result.Height  := 25;
    Result.Visible := true;
    Result.Name    := 'btn' + APanel.Name + IntToStr(AButtonCountNow + 1);
    Result.Caption := AApplicationEntry.Name;
    Result.Tag     := AApplicationEntry.Index; // Tag speichert Index in ApplicationList
    Result.OnClick := OnButtonClick;
  end;

var
  i      : Integer;
  LHeight: Integer;
begin
  DeleteButtons(AButtons);
  for i := 0 to FApplicationList.Count - 1 do
  begin
    if FApplicationList[i].Mode = AApplicationMode then
    begin;
      if AButtons.Count > 9 then
        Exit;
      AButtons.Add(AddButton(FApplicationList[i], AButtons.Count, APanel));
    end;
  end;
  APanel.Repaint;
  Application.ProcessMessages;
  APanel.Update;
  LHeight := 0;
  if AButtons.Count > 0 then
    LHeight := AButtons[AButtons.Count - 1].Top + AButtons[AButtons.Count - 1].Height;
  if FMaxPanelHeight < LHeight then
    FMaxPanelHeight := LHeight;
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
  if not FUpdatedApplicationList then
    Exit;
  FApplicationList.Clear;
  for i := 0 to Config.ApplicationCount - 1 do
  begin
    FApplicationList.Add(Config.GetApplicationEntry(i));
  end;
end;

procedure TFormPageApplication.OnButtonClick(Sender: TObject);
var
  LButton          : TButton;
  LApplicationEntry: TApplicationEntry;
  LWindow          : HWND;
begin
  if not(Sender is TButton) then
    Exit;
  LButton           := (Sender as TButton);
  LApplicationEntry := FApplicationList[LButton.Tag];
  LWindow           := FindWindow(nil, PChar(LApplicationEntry.Caption));
  if LWindow <= 0 then
    Exit;
  case LApplicationEntry.Mode of
    mdLeft:
      PinWindowToLeftHalf(LWindow, GetParentHandle, Config.MonitorNumMedia.ToInteger - 1);
    mdRight:
      PinWindowToRightHalf(LWindow, GetParentHandle, Config.MonitorNumMedia.ToInteger - 1);
    mdPresentation:
      MaximizeWindowOnMonitor(LWindow, GetParentHandle, Config.MonitorNumPresentation.ToInteger - 1);
  end;
end;

function TFormPageApplication.CompareApplicationList(AList1, AList2: TList<TApplicationEntry>): Boolean;
var
  i: Integer;
begin
  Result := true;
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

procedure TFormPageApplication.DeleteButtons(var AButtons: TButtons);
var
  i: Integer;
begin
  for i := AButtons.Count - 1 downto 0 do
  begin
    AButtons[i].Free;
  end;
  AButtons.Clear;
end;

procedure TFormPageApplication.DoPageClose;
begin
  inherited;
  FApplicationList.Free;
  FApplicationListNext.Free;
  FButtonListLeft.Free;
  FButtonListRight.Free;
  FButtonListPresentation.Free;
end;

procedure TFormPageApplication.DoPageCreate;
begin
  inherited;
  PageName                := 'Programme';
  FApplicationList        := TList<TApplicationEntry>.Create;
  FApplicationListNext    := TList<TApplicationEntry>.Create;
  FButtonListLeft         := TButtons.Create;
  FButtonListRight        := TButtons.Create;
  FButtonListPresentation := TButtons.Create;
  FillForm;
end;

procedure TFormPageApplication.DoPageShow;
begin
  inherited;
  FillForm;
end;

procedure TFormPageApplication.DoPageTimer;
begin
  inherited;
  EnableButtons(FButtonListLeft);
  EnableButtons(FButtonListRight);
  EnableButtons(FButtonListPresentation);
end;

procedure TFormPageApplication.EnableButtons(var AButtons: TButtons);
var
  i      : Integer;
  LHandle: HWND;
begin
  for i := 0 to AButtons.Count - 1 do
  begin
    LHandle             := FindWindow(nil, PChar(FApplicationList[AButtons[i].Tag].Caption));
    AButtons[i].Enabled := (LHandle <> 0);
  end;
end;

procedure TFormPageApplication.FillForm;
begin
  LoadApplicationList;
  if FUpdatedApplicationList then
  begin
    FMaxPanelHeight := 0;
    BuildButtons(mdLeft, pnlBtnLeft, FButtonListLeft);
    BuildButtons(mdRight, pnlBtnRight, FButtonListRight);
    BuildButtons(mdPresentation, pnlBtnPresentation, FButtonListPresentation);
    pnlBtnLeft.Height         := MaxPanelHeight;
    pnlBtnRight.Height        := MaxPanelHeight;
    pnlBtnPresentation.Height := MaxPanelHeight;
    Height                    := Height - pnlBtnLeft.Height + MaxPanelHeight;
    Repaint;
    Application.ProcessMessages;
    Update;
  end;
end;

end.
