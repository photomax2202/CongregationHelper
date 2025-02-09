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
  Vcl.StdCtrls;

type
  TFormConfigMonitor = class(TForm)
    sgApplications: TStringGrid;
    btnOk: TButton;
    btnCancel: TButton;
    cbxMonitorMedia: TComboBox;
    lblMonitorMedia: TLabel;
    lblMonitorPresentation: TLabel;
    cbxMonitorPresentation: TComboBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FillMonitorList;
    procedure cbxMonitorListChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    FConfig: TConfig;
  public
    { Public-Deklarationen }
  end;

var
  FormConfigMonitor: TFormConfigMonitor;

implementation

uses
  uCongregationHelper;

{$R *.dfm}

procedure TFormConfigMonitor.Button1Click(Sender: TObject);
var
  Device: TDisplayDevice;
  DeviceIndex: DWORD;
  MonitorNames: TStringList;
  AdapterName : PChar;
begin
  MonitorNames := TStringList.Create;
  try
    Device.cb := SizeOf(TDisplayDevice);
    DeviceIndex := 0;
    EnumDisplayDevices(nil, 0, Device, 0);
//    while EnumDisplayDevices(nil, 0, Device, 0) do
//    begin
//    MonitorNames.Add('MonitorIndex: ' + DeviceIndex.ToString);
//        MonitorNames.Add(string(Device.StateFlags.ToString));
//        MonitorNames.Add(string(Device.DeviceName));
//        MonitorNames.Add(string(Device.DeviceString));
//        MonitorNames.Add(string(Device.DeviceID));
//        MonitorNames.Add(string(Device.DeviceKey));
//        Inc(DeviceIndex);
//    end;
AdapterName := StrAlloc(SizeOf(Device.DeviceName));
EnumDisplayDevices(AdapterName, 0, Device, 0);
    ShowMessage('Monitor Names:' + sLineBreak + MonitorNames.Text);
  finally
    MonitorNames.Free;
  end;
end;

procedure TFormConfigMonitor.cbxMonitorListChange(Sender: TObject);
var
LDevice: TDisplayDevice;
LDeviceIndex: DWORD;
begin
if not (Sender is TComboBox) then Exit;
LDeviceIndex := Strtoint((Sender as TComboBox).Text   );
LDeviceIndex := LDeviceIndex-1;
EnumDisplayDevices(nil,LDeviceIndex,LDevice,0);
  // Screen.Monitors[0].
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
  LoadMonitorNum(FConfig.MonitorNumMedia, cbxMonitorMedia);
  LoadMonitorNum(FConfig.MonitorNumPresentation, cbxMonitorPresentation);
end;

procedure TFormConfigMonitor.FormCreate(Sender: TObject);
begin
  FConfig := FormCongregationHelper.Config;
  FillMonitorList;
end;

end.
