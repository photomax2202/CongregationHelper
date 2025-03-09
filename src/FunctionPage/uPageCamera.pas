unit uPageCamera;

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
  uPageMaster,
  Vcl.StdCtrls,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  // System.Net.URLClient,
  // System.NetConsts,
  Vcl.ExtCtrls,
  System.ImageList,
  Vcl.ImgList;

type
  TFormPageCamera = class(TFormPageMaster)
    pnlSpeaker: TPanel;
    pnlSpeakerSize: TPanel;
    btnSpeaker: TButton;
    btnSpeakerXL: TButton;
    btnSpeakerL: TButton;
    btnSpeakerS: TButton;
    btnReader: TButton;
    btnTable: TButton;
    btnLeftSpace: TButton;
    btnRightSpace: TButton;
    btnParking: TButton;
    btnTotal: TButton;
    procedure btnCameraClick(Sender: TObject);
  private
    FHttpClient : TNetHTTPClient;
    FHttpRequest: TNetHTTPRequest;
    FResponse   : IHTTPResponse;
    procedure DoPageCreate; override;
    procedure DoPageShow; override;
    procedure DoPageClose; override;
    procedure DoPageTimer; override;
    function BuildBasicAuthString(AToken: String): string;
    procedure FillButtonCaptionFirst(AText: string);
    procedure FillButtonCaptionSecond(AText: string);
    procedure FillButtonCaptionThird(AText: string);
    function HttpGetWithBasicAuth(const AURL, AEndpoint, AToken: string; out AResponseContent: string): Boolean;
    function ApiEndpointPosition(AUrl1, AUrl2: string): string;
  protected
  public

  end;

var
  FormPageCamera: TFormPageCamera;

implementation

{$R *.dfm}

function TFormPageCamera.ApiEndpointPosition(AUrl1, AUrl2: string): string;
begin
  Result := EmptyStr;
  if (AUrl1 = EmptyStr) or (AUrl2 = EmptyStr) then
    Exit;
  Result := Format('%s/%s', [AUrl1, AUrl2]);
  DoLog(Format('API Endpunkt: %s - %s', [Caption, Result]));
end;

procedure TFormPageCamera.btnCameraClick(Sender: TObject);
var
  LEndpoint, LResponse: string;
begin
  DoLog(Format('Button klick: %s - %s', [Caption, (Sender as TButton).Caption]));
  if (Sender as TButton).Name = btnSpeaker.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosSpeaker)
  else if (Sender as TButton).Name = btnSpeakerS.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosSpeakerS)
  else if (Sender as TButton).Name = btnSpeakerL.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosSpeakerL)
  else if (Sender as TButton).Name = btnSpeakerXL.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosSpeakerXL)
  else if (Sender as TButton).Name = btnReader.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosReader)
  else if (Sender as TButton).Name = btnTable.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosTable)
  else if (Sender as TButton).Name = btnLeftSpace.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosLeftSpace)
  else if (Sender as TButton).Name = btnRightSpace.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosRightSpace)
  else if (Sender as TButton).Name = btnTotal.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosTotal)
  else if (Sender as TButton).Name = btnParking.Name then
    LEndpoint := ApiEndpointPosition(Config.CameraURL, Config.CameraPosPark)
  else
    Exit;
  if LEndpoint = EmptyStr then
  begin
    DoLog(Format('API Endpunkt: %s - leer', [Caption]));
    Exit;
  end;

  // HTTP Request
  HttpGetWithBasicAuth(Config.CameraIp, LEndpoint, Config.CameraToken, LResponse);
end;

function TFormPageCamera.BuildBasicAuthString(AToken: String): string;
begin
  Result := Config.CameraToken;
  if Result = EmptyStr then
    Exit;
  Result := Format('Basic %s', [Result]);
end;

{ TFormPageFunctionSample }

procedure TFormPageCamera.DoPageClose;
begin
  inherited;
  //
end;

procedure TFormPageCamera.DoPageCreate;
begin
  inherited;
  PageName := 'Kamera';
end;

procedure TFormPageCamera.DoPageShow;
var
  i, LPosSpeaker, LPosReader, LPosTable: Integer;
begin
  inherited;
  if Config.CameraPosSpeakerIndex = EmptyStr then
    LPosSpeaker := 1
  else
    LPosSpeaker := Config.CameraPosSpeakerIndex.ToInteger;

  if Config.CameraPosReaderIndex = EmptyStr then
    LPosReader := 2
  else
    LPosReader := Config.CameraPosReaderIndex.ToInteger;

  if Config.CameraPosTableIndex = EmptyStr then
    LPosTable := 3
  else
    LPosTable := Config.CameraPosTableIndex.ToInteger;

  pnlSpeaker.Left := (LPosSpeaker - 1) * 150;
  btnReader.Left  := (LPosReader - 1) * 150;
  btnTable.Left   := (LPosTable - 1) * 150;

  if LPosSpeaker = 3 then
  begin
    pnlSpeakerSize.Left := 75;
    btnSpeaker.Left     := 0;
  end
  else
  begin

    pnlSpeakerSize.Left := 0;
    btnSpeaker.Left     := 75;
  end;
  for i := 1 to 3 do
  begin
    if LPosSpeaker = i then
    begin
      case i of
        1:
          FillButtonCaptionFirst('Redner');
        2:
          FillButtonCaptionSecond('Redner');
        3:
          FillButtonCaptionThird('Redner');
      end;
    end
    else if LPosReader = i then
    begin
      case i of
        1:
          FillButtonCaptionFirst('Leser');
        2:
          FillButtonCaptionSecond('Leser');
        3:
          FillButtonCaptionThird('Leser');
      end;
    end
    else if LPosTable = i then
    begin
      case i of
        1:
          FillButtonCaptionFirst('Tisch');
        2:
          FillButtonCaptionSecond('Tisch');
        3:
          FillButtonCaptionThird('Tisch');
      end;
    end;
  end;
end;

procedure TFormPageCamera.DoPageTimer;
begin
  inherited;
  //
end;

procedure TFormPageCamera.FillButtonCaptionFirst(AText: string);
begin
  btnLeftSpace.Caption := AText + ' + ';
end;

procedure TFormPageCamera.FillButtonCaptionSecond(AText: string);
begin
  btnLeftSpace.Caption  := btnLeftSpace.Caption + AText;
  btnRightSpace.Caption := AText + ' + ';
end;

procedure TFormPageCamera.FillButtonCaptionThird(AText: string);
begin
  btnRightSpace.Caption := btnRightSpace.Caption + AText;
end;

function TFormPageCamera.HttpGetWithBasicAuth(const AURL, AEndpoint, AToken: string;
  out AResponseContent: string): Boolean;
var
LRequestUrl:String;
begin
  Result       := false;
  FHttpClient  := TNetHTTPClient.Create(nil);
  FHttpRequest := TNetHTTPRequest.Create(nil);
  try
    FHttpRequest.Client                         := FHttpClient;
    FHttpRequest.ConnectionTimeout              := 1000;
    FHttpRequest.SendTimeout                    := 1000;
    FHttpRequest.ResponseTimeout                := 1000;
    FHttpRequest.CustomHeaders['Authorization'] := BuildBasicAuthString(Config.CameraToken);
    LRequestUrl :=    Format('http://%s/%s', [AURL, AEndpoint]);
    DoLog(Format('URL Request: %s',[LRequestUrl]));
    FResponse                                   := FHttpRequest.Get(LRequestUrl);
    if FResponse.StatusCode = 200 then
    begin
      Result           := True;
      AResponseContent := FResponse.ContentAsString;
      DoLog(Format('URL Response: %s',[AResponseContent]));
    end
    else
    begin
      Result := false;
      raise Exception.CreateFmt('HTTP GET failed with status code %d', [FResponse.StatusCode]);
    end;
  finally
    FreeAndNil(FHttpClient);
    FreeAndNil(FHttpRequest);
  end;
end;

end.
