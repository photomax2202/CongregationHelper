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
    procedure DoFormLoad; override;
    procedure DoFormShow; override;
    procedure DoFormSave(out ACanSave: Boolean); override;

    procedure FillMonitorList;
    function GetMonitorName(LMonitoNum: Integer): String;
  public
  end;

var
  FormConfigMonitor: TFormConfigMonitor;

implementation

uses
  uValidationAndHelper;

{$R *.dfm}

procedure TFormConfigMonitor.btnProgramAddClick(Sender: TObject);
var
  LName, LCaption, LClass, LMode: String;
  sl                            : TStringList;
begin
  sl := TStringList.Create;
  try
    if GetWindowEntry(LName, LCaption, LClass, LMode) <> mrOk then
      Exit;
    LCaption           := ReplaceCharactersEnumWindows(LCaption);
    sl.Delimiter       := ';';
    sl.StrictDelimiter := true;
    sl.AddPair(cIdentsApplication[apName], LName);
    sl.AddPair(cIdentsApplication[apCaption], LCaption);
    sl.AddPair(cIdentsApplication[apClass], LClass);
    sl.AddPair(cIdentsApplication[apMode], LMode);
    lbPrograms.Items.Add(sl.DelimitedText);
    DoLog(Format('AddProgramm: %s', [sl.DelimitedText]));
  finally
    sl.Free;
  end;
end;

procedure TFormConfigMonitor.btnProgramBottomClick(Sender: TObject);
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  inherited;
  SelectedIndex := lbPrograms.ItemIndex;
  if (SelectedIndex >= 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    DoLog(Format('Button klick', [(Sender as TButton).Caption]));
    SelectedText := lbPrograms.Items[SelectedIndex];
    lbPrograms.Items.Delete(SelectedIndex);
    lbPrograms.Items.Insert(lbPrograms.Items.Count - 1, SelectedText);
    lbPrograms.ItemIndex := lbPrograms.Items.Count - 1;
  end;
end;

procedure TFormConfigMonitor.btnProgramDeleteClick(Sender: TObject);
var
  SelectedIndex: Integer;
begin
  inherited;
  SelectedIndex := lbPrograms.ItemIndex;
  if (SelectedIndex >= 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    DoLog(Format('Delete Application: %s', [lbPrograms.Items[SelectedIndex]]));
    lbPrograms.Items.Delete(SelectedIndex);
    lbPrograms.ItemIndex := SelectedIndex - 1;
  end;
end;

procedure TFormConfigMonitor.btnProgramDownClick(Sender: TObject);
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  inherited;
  SelectedIndex := lbPrograms.ItemIndex;
  if (SelectedIndex >= 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    DoLog(Format('Button klick', [(Sender as TButton).Caption]));
    SelectedText := lbPrograms.Items[SelectedIndex];
    lbPrograms.Items.Delete(SelectedIndex);
    lbPrograms.Items.Insert(SelectedIndex + 1, SelectedText);
    lbPrograms.ItemIndex := SelectedIndex + 1;
  end;
end;

procedure TFormConfigMonitor.btnProgramTopClick(Sender: TObject);
var
  SelectedIndex: Integer;
  SelectedText : string;
begin
  inherited;
  SelectedIndex := lbPrograms.ItemIndex;
  if (SelectedIndex >= 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    DoLog(Format('Button klick', [(Sender as TButton).Caption]));
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
  if (SelectedIndex >= 0) and (SelectedIndex < lbPrograms.Items.Count) then
  begin
    DoLog(Format('Button klick', [(Sender as TButton).Caption]));
    SelectedText := lbPrograms.Items[SelectedIndex];
    lbPrograms.Items.Delete(SelectedIndex);
    lbPrograms.Items.Insert(SelectedIndex - 1, SelectedText);
    lbPrograms.ItemIndex := SelectedIndex - 1;
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

procedure TFormConfigMonitor.DoFormSave(out ACanSave: Boolean);
var
  i                : Integer;
  sl               : TStringList;
  LApplicationEntry: TApplicationEntry;
begin
  inherited;
  sl := TStringList.Create;
  try
    sl.Delimiter                  := ';';
    sl.StrictDelimiter            := true;
    Config.MonitorNumMedia        := cbxMonitorMedia.Items[cbxMonitorMedia.ItemIndex];
    Config.MonitorNumPresentation := cbxMonitorPresentation.Items[cbxMonitorPresentation.ItemIndex];
    for i                         := 0 to cMaxProgrammCount do
    begin
      Config.DeleteApplicationEntry(i);
    end;
    for i := 0 to lbPrograms.Count - 1 do
    begin
      sl.DelimitedText := lbPrograms.Items[i];
      if sl.IndexOfName(cIdentsApplication[apName]) = -1 then
        Exit;
      if sl.IndexOfName(cIdentsApplication[apCaption]) = -1 then
        Exit;
      if sl.IndexOfName(cIdentsApplication[apClass]) = -1 then
        Exit;
      if sl.IndexOfName(cIdentsApplication[apMode]) = -1 then
        Exit;
      LApplicationEntry.Index   := i;
      LApplicationEntry.Name    := sl.Values[cIdentsApplication[apName]];
      LApplicationEntry.Caption := sl.Values[cIdentsApplication[apCaption]];
      LApplicationEntry.sClass  := sl.Values[cIdentsApplication[apClass]];
      LApplicationEntry.Mode    := Config.GetApplicationMode(sl.Values[cIdentsApplication[apMode]]);
      Config.SetApplicationEntry(LApplicationEntry);
    end;
    ACanSave := true;
  finally
    sl.Free;
  end;
end;

procedure TFormConfigMonitor.DoFormShow;
var
  i                : Integer;
  LApplicationEntry: TApplicationEntry;
  sl               : TStringList;
begin
  inherited;
  sl := TStringList.Create;
  try
    sl.Delimiter       := ';';
    sl.StrictDelimiter := true;
    cbxMonitorMedia.OnChange(cbxMonitorMedia);
    cbxMonitorPresentation.OnChange(cbxMonitorPresentation);
    if Config.ApplicationCount > 0 then
    begin
      lbPrograms.Clear;
      for i := 0 to cMaxProgrammCount - 1 do
      begin
        if Config.ApplicationExists(i) then
        begin
          LApplicationEntry := Config.GetApplicationEntry(i);
          sl.AddPair(cIdentsApplication[apName], LApplicationEntry.Name);
          sl.AddPair(cIdentsApplication[apCaption], LApplicationEntry.Caption);
          sl.AddPair(cIdentsApplication[apClass], LApplicationEntry.sClass);
          sl.AddPair(cIdentsApplication[apMode], cApplicationMode[LApplicationEntry.Mode]);
          lbPrograms.Items.Add(sl.DelimitedText);
          sl.Clear;
        end;
      end;
    end;
  finally
    sl.Free;
  end;
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
  DoLog('FillMonitorList');
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
