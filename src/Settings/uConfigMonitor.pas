unit uConfigMonitor;

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
  uConfig,
  Vcl.Grids,
  Vcl.StdCtrls,
  uConfigFormMaster,
  Vcl.ExtCtrls,
  uProgramList;

type
  TFormConfigMonitor = class(TForrmConfigMaster)
    cbxMonitorMedia: TComboBox;
    lblMonitorMedia: TLabel;
    lblMonitorPresentation: TLabel;
    cbxMonitorPresentation: TComboBox;
    edtMonitorNameMedia: TEdit;
    edtMonitorNamePresentation: TEdit;
    lbPrograms: TListBox;
    lblPrograms: TLabel;
    btnProgramUp: TButton;
    btnProgramTop: TButton;
    btnProgramAdd: TButton;
    btnProgramDelete: TButton;
    btnProgramDown: TButton;
    btnProgramBottom: TButton;
    procedure cbxMonitorListChange(Sender: TObject);
    procedure btnProgramTopClick(Sender: TObject);
    procedure btnProgramUpClick(Sender: TObject);
    procedure btnProgramBottomClick(Sender: TObject);
    procedure btnProgramDownClick(Sender: TObject);
    procedure btnProgramAddClick(Sender: TObject);
    procedure btnProgramDeleteClick(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure DoFormLoad; override;
    procedure DoFormShow; override;
    procedure DoFormSave; override;

    procedure FillMonitorList;
    function GetMonitorName(LMonitoNum: Integer): String;
  public
    { Public-Deklarationen }
  end;

var
  FormConfigMonitor: TFormConfigMonitor;

implementation

{$R *.dfm}

procedure TFormConfigMonitor.btnProgramAddClick(Sender: TObject);
var
  LName, LCaption: String;
begin
  if GetWindowEntry(LName, LCaption) <> mrOk then
    Exit;
  lbPrograms.Items.Add(Format('Name=%s;Caption=%s',[LName,LCaption]));
end;

procedure TFormConfigMonitor.btnProgramBottomClick(Sender: TObject);
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  inherited;
  SelectedIndex := lbPrograms.ItemIndex;
  if (SelectedIndex > 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    SelectedText := lbPrograms.Items[SelectedIndex];
    lbPrograms.Items.Delete(SelectedIndex);
    lbPrograms.Items.Insert(lbPrograms.Items.Count-1, SelectedText);
    lbPrograms.ItemIndex := lbPrograms.Items.Count-1;
  end;
end;

procedure TFormConfigMonitor.btnProgramDeleteClick(Sender: TObject);
begin
  inherited;
  lbPrograms.Items.Delete(lbPrograms.ItemIndex);
end;

procedure TFormConfigMonitor.btnProgramDownClick(Sender: TObject);
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  inherited;
  SelectedIndex := lbPrograms.ItemIndex;
  if (SelectedIndex > 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    SelectedText := lbPrograms.Items[SelectedIndex];
    lbPrograms.Items.Delete(SelectedIndex);
    lbPrograms.Items.Insert(SelectedIndex+1, SelectedText);
    lbPrograms.ItemIndex := SelectedIndex+1;
  end;
end;

procedure TFormConfigMonitor.btnProgramTopClick(Sender: TObject);
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  inherited;
  SelectedIndex := lbPrograms.ItemIndex;
  if (SelectedIndex > 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    SelectedText := lbPrograms.Items[SelectedIndex];
    lbPrograms.Items.Delete(SelectedIndex);
    lbPrograms.Items.Insert(0, SelectedText);
    lbPrograms.ItemIndex := 0;
  end;
end;

procedure TFormConfigMonitor.btnProgramUpClick(Sender: TObject);
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  inherited;
  SelectedIndex := lbPrograms.ItemIndex;
  if (SelectedIndex > 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    SelectedText := lbPrograms.Items[SelectedIndex];
    lbPrograms.Items.Delete(SelectedIndex);
    lbPrograms.Items.Insert(SelectedIndex-1, SelectedText);
    lbPrograms.ItemIndex := SelectedIndex-1;
  end;
end;

procedure TFormConfigMonitor.cbxMonitorListChange(Sender: TObject);
var
  LDevice     : TDisplayDevice;
  LDeviceIndex: DWORD;
begin
  if not(Sender is TComboBox) then
    Exit;
  if (Sender as TComboBox).Name = cbxMonitorMedia.Name then
  begin
    edtMonitorNameMedia.Text := GetMonitorName(cbxMonitorMedia.ItemIndex);
  end
  else if (Sender as TComboBox).Name = cbxMonitorPresentation.Name then
  begin
    edtMonitorNamePresentation.Text := GetMonitorName(cbxMonitorPresentation.ItemIndex);
  end;

end;

procedure TFormConfigMonitor.DoFormLoad;
begin
  inherited;
  FillMonitorList;
end;

procedure TFormConfigMonitor.DoFormSave;
begin
  inherited;

end;

procedure TFormConfigMonitor.DoFormShow;
begin
  inherited;
  cbxMonitorMedia.OnChange(cbxMonitorMedia);
  cbxMonitorPresentation.OnChange(cbxMonitorPresentation);
end;

procedure TFormConfigMonitor.FillMonitorList;

  procedure LoadMonitorNum(AMonitorNum: String; AMonitroList: TComboBox);
  begin
    if AMonitorNum = EmptyStr then
    begin
      AMonitroList.ItemIndex := 0
    end
    else
    begin
      AMonitroList.ItemIndex := AMonitroList.Items.IndexOf(AMonitorNum);
      if AMonitroList.ItemIndex < 0 then
        AMonitroList.ItemIndex := 0;
    end;
  end;

var
  LMonitor: TMonitor;
  i       : Integer;
begin
  cbxMonitorMedia.Clear;
  cbxMonitorPresentation.Clear;
  for i := 1 to Screen.MonitorCount do
  begin
    cbxMonitorMedia.Items.Add(i.ToString);
    cbxMonitorPresentation.Items.Add(i.ToString);
  end;
  LoadMonitorNum(Config.MonitorNumMedia, cbxMonitorMedia);
  LoadMonitorNum(Config.MonitorNumPresentation, cbxMonitorPresentation);
end;

function TFormConfigMonitor.GetMonitorName(LMonitoNum: Integer): String;
var
  dd, md: TDisplayDevice;
begin
  Result := EmptyStr;
  FillChar(dd, SizeOf(dd), 0);
  dd.cb := SizeOf(dd);
  FillChar(md, SizeOf(md), 0);
  md.cb := SizeOf(md);
  var
  i := LMonitoNum;
  while EnumDisplayDevices(nil, i, dd, 0) do
  begin
    var
    j := 0;
    while EnumDisplayDevices(@dd.DeviceName[0], j, md, 0) do
    begin
      Result := md.DeviceString;
      Inc(j);
    end;
    Inc(i);
  end;
end;

end.
