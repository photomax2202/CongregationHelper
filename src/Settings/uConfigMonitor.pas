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
    cbxMonitorList: TComboBox;
    lblMonitorSelection: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FillMonitorList;
    procedure cbxMonitorListChange(Sender: TObject);
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

procedure TFormConfigMonitor.cbxMonitorListChange(Sender: TObject);
begin
//Screen.Monitors[0].
end;

procedure TFormConfigMonitor.FillMonitorList;
var
  LMonitor: TMonitor;
  i       : Integer;
begin
  cbxMonitorList.Clear;
  for i := 1 to Screen.MonitorCount do
  begin
    cbxMonitorList.Items.Add(i.ToString);
  end;
  if FConfig.MonitorNum = EmptyStr then
  begin
    cbxMonitorList.ItemIndex := 0
  end
  else
  begin
    cbxMonitorList.ItemIndex := cbxMonitorList.Items.IndexOf(FConfig.MonitorNum);
    if cbxMonitorList.ItemIndex < 0 then
      cbxMonitorList.ItemIndex := 0;
  end;

end;

procedure TFormConfigMonitor.FormCreate(Sender: TObject);
begin
  FConfig := FormCongregationHelper.Config;
  FillMonitorList;
end;

end.
