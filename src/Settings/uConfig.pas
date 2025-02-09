unit uConfig;

interface

uses
  IniFiles,
  SysUtils;

type
  TSections = (scGeneral, scCamera, scMonitor);

  TIdentsGeneral = (idAlwaysOnTop);

  TIdentsCamera = (idCamToken, idCamIP, idCamURL, idCamPosSpeaker, idCamPosSpeakerS, idCamPosSpeakerL,
    idCamPosSpeakerXL, idCamPosReader, idCamPosTable, idCamPosSpeakerReader, idCamPosReaderTable, idCamPosTotal,
    idCamPosPark);

  TIdentsMonitor = (idMonNum);

  TIdentsApplication = (apName, apCaption);

  TApplicationEntry = record
    Index: Integer;
    Name: String;
    Caption: String;
  end;

  TConfig = class(TIniFile)
  private
    function GetBoolGeneral(Index: TIdentsGeneral): Boolean;
    procedure SetBoolGeneral(Index: TIdentsGeneral; const Value: Boolean);
    function GetStringCamera(Index: TIdentsCamera): String;
    procedure SetStringCamera(Index: TIdentsCamera; const Value: String);
    function GetStringMonitor(Index: TIdentsMonitor): String;
    procedure SetStringMonitor(Index: TIdentsMonitor; const Value: String);

    function GetApplicationSection(ANum: Integer): string;
    function GetApplicationCount: Integer;
    procedure SetApplicationEntry(AApplicationEntry: TApplicationEntry);
    function GetApplicationEntry(ANum: Integer): TApplicationEntry;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor Create;

    property AlwaysOnTop: Boolean
      index  idAlwaysOnTop
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
    property CameraPosSpeakerReader: String
      index  idCamPosSpeakerReader
      read   GetStringCamera
      write  SetStringCamera;
    property CameraPosReaderTable: String
      index  idCamPosReaderTable
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

    property MonitorNum: String
      index  idMonNum
      read   GetStringMonitor
      write  SetStringMonitor;

    property ApplicationCount: Integer
      read   GetApplicationCount;
  end;

const
  cSections: array [TSections] of string = ('General', 'Camera', 'Monitor');

  cIdentsGeneral: array [TIdentsGeneral] of string = ('AlwaysOnTop');

  cIdentsCamera: array [TIdentsCamera] of string = ('Token', 'IP', 'URL', 'Speaker', 'SpeakerS', 'SpeakerL',
    'SpeakerXL', 'Reader', 'Table', 'SpeakerReader', 'ReaderTable', 'Total', 'Park');

  cIdentsMonitor: array [TIdentsMonitor] of string = ('MonitorNum');

  cIdentsApplication: array [TIdentsApplication] of string = ('Name', 'Caption');

implementation

uses
  Classes;

{ TConfig }

constructor TConfig.Create;
var
  LIniPath: string;
begin
  LIniPath := ChangeFileExt(ParamStr(0), '.ini');
  inherited Create(LIniPath);
end;

function TConfig.GetApplicationCount: Integer;
var
  i: Integer;
begin
  for i := 1 to 99 do
  begin
    Result := 0;
    if SectionExists(GetApplicationSection(i)) then
      Result := i
    else
      Exit;
  end;
end;

function TConfig.GetApplicationEntry(ANum: Integer): TApplicationEntry;
begin
  Result.Index   := ANum;
  Result.Name    := ReadString(GetApplicationSection(ANum), cIdentsApplication[apName], EmptyStr);
  Result.Caption := ReadString(GetApplicationSection(ANum), cIdentsApplication[apCaption], EmptyStr);
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
