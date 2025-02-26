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
  System.Net.URLClient,
  System.NetConsts;

type
  TFormPageCamera = class(TFormPageMaster)
  private
    procedure DoPageCreate; override;
    procedure DoPageShow; override;
    procedure DoPageClose; override;
    procedure DoPageTimer; override;
    function BuildBasicAuthString(AToken: String): string;
  protected
    FHttpClient : THTTPClient;
    FHttpRequest: THTTPRequest;
    FResponse   : IHTTPResponse;
  public

  end;

var
  FormPageCamera: TFormPageCamera;

implementation

{$R *.dfm}
function TFormPageCamera.BuildBasicAuthString(AToken: String): string;
begin
Result := Config.CameraToken;
if Result = EmptyStr then Exit;
Result := Format('Basic %s',[Result]);
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
begin
  inherited;
  //
end;

procedure TFormPageCamera.DoPageTimer;
begin
  inherited;
  //
end;

end.
