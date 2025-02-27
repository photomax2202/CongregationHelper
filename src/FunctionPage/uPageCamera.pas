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
  Vcl.ExtCtrls;

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
    btnHomePosition: TButton;
    btnTotal: TButton;
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
  protected
  public

  end;

var
  FormPageCamera: TFormPageCamera;

implementation

{$R *.dfm}

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
  i: Integer;
begin
  inherited;
  pnlSpeaker.Left := (Config.CameraPosSpeakerIndex.ToInteger - 1) * 150;
  btnReader.Left  := (Config.CameraPosReaderIndex.ToInteger - 1) * 150;
  btnTable.Left   := (Config.CameraPosTableIndex.ToInteger - 1) * 150;
  for i           := 1 to 3 do
  begin
    if Config.CameraPosSpeakerIndex.ToInteger = i then
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
    else if Config.CameraPosReaderIndex.ToInteger = i then
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
    else if Config.CameraPosTableIndex.ToInteger = i then
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
begin
  Result       := false;
  FHttpClient  := TNetHTTPClient.Create(nil);
  FHttpRequest := TNetHTTPRequest.Create(nil);
  try
    FHttpRequest.Client                         := FHttpClient;
    FHttpRequest.CustomHeaders['Authorization'] := BuildBasicAuthString(Config.CameraToken);
    FResponse                                   := FHttpRequest.Get(Format('https://%s/%s', [AURL, AEndpoint]));
    if FResponse.StatusCode = 200 then
    begin
      Result           := True;
      AResponseContent := FResponse.ContentAsString;
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
