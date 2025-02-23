unit uMonitorHandler;

interface

uses
  Windows,
  Forms,
  SysUtils,
  MultiMon;


procedure PinWindowToLeftHalf(AHandle: HWND; MonitorIndex: Integer);
procedure PinWindowToRightHalf(AHandle: HWND; MonitorIndex: Integer);
procedure MaximizeWindowOnMonitor(AHandle: HWND; MonitorIndex: Integer);

implementation

procedure PinWindowToLeftHalf(AHandle: HWND; MonitorIndex: Integer);
var
  Monitors    : array of HMONITOR;
  MonitorCount: Integer;
  MonitorInfo : TMonitorInfo;
  Rect        : TRect;
begin
  // Initialize monitor info
  MonitorInfo.cbSize := SizeOf(MonitorInfo);

  // Enumerate monitors
  MonitorCount := Screen.MonitorCount;
  if (MonitorIndex < 0) or (MonitorIndex >= MonitorCount) then
    raise Exception.Create('Invalid monitor index');

  Monitors := nil;
  SetLength(Monitors, MonitorCount);

  for var i     := 0 to MonitorCount - 1 do
    Monitors[i] := Screen.Monitors[i].Handle;

  // Get information of the specified monitor
  if GetMonitorInfo(Monitors[MonitorIndex], @MonitorInfo) then
  begin
    Rect := MonitorInfo.rcWork;
    // Calculate the new dimensions for the window
    Rect.Right := Rect.Left + (Rect.Right - Rect.Left) div 2;
    // Move and resize the window
    MoveWindow(AHandle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, True);
  end;
end;

procedure PinWindowToRightHalf(AHandle: HWND; MonitorIndex: Integer);
var
  Monitors    : array of HMONITOR;
  MonitorCount: Integer;
  MonitorInfo : TMonitorInfo;
  Rect        : TRect;
begin
  // Initialize monitor info
  MonitorInfo.cbSize := SizeOf(MonitorInfo);

  // Enumerate monitors
  MonitorCount := Screen.MonitorCount;
  if (MonitorIndex < 0) or (MonitorIndex >= MonitorCount) then
    raise Exception.Create('Invalid monitor index');

  Monitors := nil;
  SetLength(Monitors, MonitorCount);

  for var i     := 0 to MonitorCount - 1 do
    Monitors[i] := Screen.Monitors[i].Handle;

  // Get information of the specified monitor
  if GetMonitorInfo(Monitors[MonitorIndex], @MonitorInfo) then
  begin
    Rect := MonitorInfo.rcWork;
    // Calculate the new dimensions for the window
    Rect.Left := Rect.Left + (Rect.Right - Rect.Left) div 2;
    // Move and resize the window
    MoveWindow(AHandle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, True);
  end;
end;

procedure MaximizeWindowOnMonitor(AHandle: HWND; MonitorIndex: Integer);
var
  Monitors: array of HMONITOR;
  MonitorCount: Integer;
  MonitorInfo: TMonitorInfo;
  Rect: TRect;
begin
  // Initialize monitor info
  MonitorInfo.cbSize := SizeOf(MonitorInfo);

  // Enumerate monitors
  MonitorCount := Screen.MonitorCount;
  if (MonitorIndex < 0) or (MonitorIndex >= MonitorCount) then
    raise Exception.Create('Invalid monitor index');

  Monitors := nil;
  SetLength(Monitors, MonitorCount);

  for var i := 0 to MonitorCount - 1 do
    Monitors[i] := Screen.Monitors[i].Handle;

  // Get information of the specified monitor
  if GetMonitorInfo(Monitors[MonitorIndex], @MonitorInfo) then
  begin
    Rect := MonitorInfo.rcWork;
    // Move and resize the window to occupy the entire monitor's work area
    MoveWindow(AHandle, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, True);
  end;
end;

end.
