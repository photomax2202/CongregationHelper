unit uConfig;

interface

uses
  IniFiles,
  SysUtils;

type
  TSections = (scGeneral, scCamera, scMonitor);

  TIdentsGeneral = (idAlwaysOnTop, idZoomMonitoring, idPreReleaseVersion);

  TIdentsCamera = (idCamToken, idCamIP, idCamURL, idCamPosSpeaker, idCamPosSpeakerS, idCamPosSpeakerL,
    idCamPosSpeakerXL, idCamPosReader, idCamPosTable, idCamPosLeftSpace, idCamPosRightSpace, idCamPosTotal,
    idCamPosPark, idCamPosSpeakerIndex, idCamPosReaderIndex, idCamPosTableIndex);

  TIdentsMonitor = (idMonNumMedia, idMonNumPresentation);

  TIdentsApplication = (apName, apCaption, apMode);

  TApplicationMode = (mdLeft, mdRight, mdPresentation);

  TApplicationEntry = record
    Index: Integer;
    Name: String;
    Caption: String;
    Mode: TApplicationMode;
  end;

  TConfig = class(TIniFile)
  private
    function GetBoolGeneral(Index: TIdentsGeneral): Boolean;
    procedure SetBoolGeneral(Index: TIdentsGeneral; const Value: Boolean);
    function GetStringCamera(Index: TIdentsCamera): String;
    procedure SetStringCamera(Index: TIdentsCamera; const Value: String);
    function GetStringMonitor(Index: TIdentsMonitor): String;
    procedure SetStringMonitor(Index: TIdentsMonitor; const Value: String);

    function GetApplicationCount: Integer;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor Create;

    property AlwaysOnTop: Boolean
      index  idAlwaysOnTop
      read   GetBoolGeneral
      write  SetBoolGeneral;
    property ZoomMonitoring: Boolean
      index  idZoomMonitoring
      read   GetBoolGeneral
      write  SetBoolGeneral;
    property PreReleaseVersionen: Boolean
      index  idPreReleaseVersion
      read   GetBoolGeneral
      write  SetBoolGeneral;

    property CameraToken: String
      index  idCamToken
      read   GetStringCamera
      write  SetStringCamera;
    property CameraIp: String
      index  idCamIP
      read   GetStringCamera
      write  SetStringCamera;
    property CameraURL: String
      index  idCamURL
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosSpeaker: String
      index  idCamPosSpeaker
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosSpeakerS: String
      index  idCamPosSpeakerS
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosSpeakerL: String
      index  idCamPosSpeakerL
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosSpeakerXL: String
      index  idCamPosSpeakerXL
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosReader: String
      index  idCamPosReader
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosTable: String
      index  idCamPosTable
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosLeftSpace: String
      index  idCamPosLeftSpace
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosRightSpace: String
      index  idCamPosRightSpace
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosTotal: String
      index  idCamPosTotal
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosPark: String
      index  idCamPosPark
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosSpeakerIndex: String
      index  idCamPosSpeakerIndex
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosReaderIndex: String
      index  idCamPosReaderIndex
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosTableIndex: String
      index  idCamPosTableIndex
      read   GetStringCamera
      write  SetStringCamera;

    property MonitorNumMedia: String
      index  idMonNumMedia
      read   GetStringMonitor
      write  SetStringMonitor;
    property MonitorNumPresentation: String
      index  idMonNumPresentation
      read   GetStringMonitor
      write  SetStringMonitor;

    property ApplicationCount: Integer
      read   GetApplicationCount;

    procedure SetApplicationEntry(AApplicationEntry: TApplicationEntry);
    procedure DeleteApplicationEntry(ANum: Integer);
    function GetApplicationEntry(ANum: Integer): TApplicationEntry;
    function GetApplicationSection(ANum: Integer): string;
    function ApplicationExists(ANum: Integer): Boolean;
    function GetApplicationMode(AMode: string): TApplicationMode;
  end;

const
  cSections: array [TSections] of string = ('General', 'Camera', 'Monitor');

  cIdentsGeneral: array [TIdentsGeneral] of string = ('AlwaysOnTop', 'ZoomMonitoring', 'PreReleaseVersion');

  cIdentsCamera: array [TIdentsCamera] of string = ('Token', 'IP', 'URL', 'Speaker', 'SpeakerS', 'SpeakerL',
    'SpeakerXL', 'Reader', 'Table', 'LeftSpace', 'RightSpace', 'Total', 'Park', 'SpeakerIndex', 'ReadeIndex',
    'TableIndex');

  cIdentsMonitor: array [TIdentsMonitor] of string = ('MonitorNumMedia', 'MonitorNumPresentation');

  cIdentsApplication: array [TIdentsApplication] of string = ('Name', 'Caption', 'Mode');
  cApplicationMode: array [TApplicationMode] of string = ('Links Anheften','Rechts Anheften','Präsentation');

  cMaxProgrammCount = 99;

implementation

uses
  Classes;

{ TConfig }

function TConfig.ApplicationExists(ANum: Integer): Boolean;
begin
  Result := SectionExists(GetApplicationSection(ANum));
end;

constructor TConfig.Create;
var
  LIniPath: string;
begin
  LIniPath := ChangeFileExt(ParamStr(0), '.ini');
  inherited Create(LIniPath);
end;

procedure TConfig.DeleteApplicationEntry(ANum: Integer);
begin
  if SectionExists(GetApplicationSection(ANum)) then
    EraseSection(GetApplicationSection(ANum));
end;

function TConfig.GetApplicationCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i  := 0 to cMaxProgrammCount do
  begin
    if SectionExists(GetApplicationSection(i)) then
      Result := Result + 1;
  end;
end;

function TConfig.GetApplicationEntry(ANum: Integer): TApplicationEntry;
begin
  Result.Index   := ANum;
  Result.Name    := ReadString(GetApplicationSection(ANum), cIdentsApplication[apName], EmptyStr);
  Result.Caption := ReadString(GetApplicationSection(ANum), cIdentsApplication[apCaption], EmptyStr);
  Result.Mode    := GetApplicationMode(ReadString(GetApplicationSection(ANum), cIdentsApplication[apMode], EmptyStr));
end;

function TConfig.GetApplicationMode(AMode: string): TApplicationMode;
begin
if SameStr(AMode,cApplicationMode[mdLeft]) then
Result := mdLeft
else if SameStr(AMode,cApplicationMode[mdRight]) then
Result := mdRight
else if SameStr(AMode,cApplicationMode[mdPresentation]) then
Result := mdPresentation
else
Result := mdPresentation;
end;

function TConfig.GetApplicationSection(ANum: Integer): string;
begin
  Result := Format('Application%.2d', [ANum])
end;

function TConfig.GetBoolGeneral(Index: TIdentsGeneral): Boolean;
begin
  Result := ReadBool(cSections[scGeneral], cIdentsGeneral[Index], False);
end;

function TConfig.GetStringCamera(Index: TIdentsCamera): String;
begin
  Result := ReadString(cSections[scCamera], cIdentsCamera[Index], EmptyStr);
end;

function TConfig.GetStringMonitor(Index: TIdentsMonitor): String;
begin
  Result := ReadString(cSections[scMonitor], cIdentsMonitor[Index], EmptyStr);
end;

procedure TConfig.SetApplicationEntry(AApplicationEntry: TApplicationEntry);
begin
  WriteString(GetApplicationSection(AApplicationEntry.Index), cIdentsApplication[apName], AApplicationEntry.Name);
  WriteString(GetApplicationSection(AApplicationEntry.Index), cIdentsApplication[apCaption], AApplicationEntry.Caption);
  WriteString(GetApplicationSection(AApplicationEntry.Index), cIdentsApplication[apMode], cApplicationMode[AApplicationEntry.Mode]);
end;

procedure TConfig.SetBoolGeneral(Index: TIdentsGeneral; const Value: Boolean);
begin
  WriteBool(cSections[scGeneral], cIdentsGeneral[Index], Value);
end;

procedure TConfig.SetStringCamera(Index: TIdentsCamera; const Value: String);
begin
  WriteString(cSections[scCamera], cIdentsCamera[Index], Value);
end;

procedure TConfig.SetStringMonitor(Index: TIdentsMonitor; const Value: String);
begin
  WriteString(cSections[scMonitor], cIdentsMonitor[Index], Value);
end;

end.
