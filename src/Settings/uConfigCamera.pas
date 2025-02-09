unit uConfigCamera;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, uConfig;

type
  TFormConfigCamera = class(TForm)
    ledUsername: TLabeledEdit;
    ledPassword: TLabeledEdit;
    ledToken: TLabeledEdit;
    ledIP: TLabeledEdit;
    ledMidURL: TLabeledEdit;
    ledPosSpeaker: TLabeledEdit;
    lblPositions: TLabel;
    ledPosReader: TLabeledEdit;
    ledPosTable: TLabeledEdit;
    ledPosSpeakerReader: TLabeledEdit;
    ledPosReaderTable: TLabeledEdit;
    ledPosSpeakerS: TLabeledEdit;
    ledPosSpeakerL: TLabeledEdit;
    ledPosSpeakerXL: TLabeledEdit;
    ledPosTotal: TLabeledEdit;
    btnOk: TButton;
    btnCancel: TButton;
    ledPosPark: TLabeledEdit;
    procedure ledCredentialsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure ledFieldValidation(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    FConfig: TConfig;
  public
    { Public-Deklarationen }
  end;

var
  FormConfigCamera: TFormConfigCamera;

implementation

uses
  uCongregationHelper,
  uValidation,
  System.NetEncoding;

{$R *.dfm}

procedure TFormConfigCamera.btnOkClick(Sender: TObject);
var
  LValid: Boolean;
begin
  LValid := False;
  try
    if not ValidateToken(ledToken.Text) then
      Exit;
    if not ValidateIP(ledIP.Text) then
      Exit;
    if not ValidateUrl(ledMidURL.Text) then
      Exit;
    if not ValidatePosition(ledPosSpeaker.Text) then
      Exit;
    if not ValidatePosition(ledPosSpeakerS.Text) then
      Exit;
    if not ValidatePosition(ledPosSpeakerL.Text) then
      Exit;
    if not ValidatePosition(ledPosSpeakerXL.Text) then
      Exit;
    if not ValidatePosition(ledPosReader.Text) then
      Exit;
    if not ValidatePosition(ledPosTable.Text) then
      Exit;
    if not ValidatePosition(ledPosSpeakerReader.Text) then
      Exit;
    if not ValidatePosition(ledPosReaderTable.Text) then
      Exit;
    if not ValidatePosition(ledPosTotal.Text) then
      Exit;
    if not ValidatePosition(ledPosPark.Text) then
      Exit;
    LValid := True;

    FConfig.CameraToken            := ledToken.Text;
    FConfig.CameraIp               := ledIP.Text;
    FConfig.CameraURL              := ledMidURL.Text;
    FConfig.CameraPosSpeaker       := ledPosSpeaker.Text;
    FConfig.CameraPosSpeakerS      := ledPosSpeakerS.Text;
    FConfig.CameraPosSpeakerL      := ledPosSpeakerL.Text;
    FConfig.CameraPosSpeakerXL     := ledPosSpeakerXL.Text;
    FConfig.CameraPosReader        := ledPosReader.Text;
    FConfig.CameraPosTable         := ledPosTable.Text;
    FConfig.CameraPosSpeakerReader := ledPosSpeakerReader.Text;
    FConfig.CameraPosReaderTable   := ledPosReaderTable.Text;
    FConfig.CameraPosTotal         := ledPosTotal.Text;
    FConfig.CameraPosPark          := ledPosPark.Text;
  finally
    if not LValid then
      ShowMessage('Markiertes Feld hat nicht das richtige Format.');
  end;
end;

procedure TFormConfigCamera.FormCreate(Sender: TObject);
begin
  FConfig := FormCongregationHelper.Config;
  if FConfig.CameraIp = EmptyStr then
    FConfig.CameraIp := '0.0.0.0';
  if FConfig.CameraURL = EmptyStr then
    FConfig.CameraURL := '';

end;

procedure TFormConfigCamera.FormShow(Sender: TObject);
begin
  ledToken.Text            := FConfig.CameraToken;
  ledIP.Text               := FConfig.CameraIp;
  ledMidURL.Text           := FConfig.CameraURL;
  ledPosSpeaker.Text       := FConfig.CameraPosSpeaker;
  ledPosSpeakerS.Text      := FConfig.CameraPosSpeakerS;
  ledPosSpeakerL.Text      := FConfig.CameraPosSpeakerL;
  ledPosSpeakerXL.Text     := FConfig.CameraPosSpeakerXL;
  ledPosReader.Text        := FConfig.CameraPosReader;
  ledPosTable.Text         := FConfig.CameraPosTable;
  ledPosSpeakerReader.Text := FConfig.CameraPosSpeakerReader;
  ledPosReaderTable.Text   := FConfig.CameraPosReaderTable;
  ledPosTotal.Text         := FConfig.CameraPosTotal;
  ledPosPark.Text          := FConfig.CameraPosPark;
end;

procedure TFormConfigCamera.ledCredentialsChange(Sender: TObject);
var
  Coder: TBase64StringEncoding;
begin
  Coder := TBase64StringEncoding.Create;
  try
    ledToken.Text := Coder.Encode(Format('%s:%s', [ledUsername.Text, ledPassword.Text]));
  finally
    Coder.Free;
  end;
  if (Length(ledUsername.Text) + Length(ledPassword.Text) = 0) then
    ledToken.Text := EmptyStr;
end;

procedure TFormConfigCamera.ledFieldValidation(Sender: TObject);
var
  LValid: Boolean;
  LName : String;
  LText : string;
begin
  LName := (Sender as TLabeledEdit).Name;
  LText := (Sender as TLabeledEdit).Text;
  if LName = ledToken.Name then
    MarkValidation(ledToken, ValidateToken(LText))
  else if LName = ledIP.Name then
    MarkValidation(ledIP, ValidateIP(LText))
  else if LName = ledMidURL.Name then
    MarkValidation(ledMidURL, ValidateUrl(LText))
  else if LName = ledPosSpeaker.Name then
    MarkValidation(ledPosSpeaker, ValidatePosition(LText))
  else if LName = ledPosSpeakerS.Name then
    MarkValidation(ledPosSpeakerS, ValidatePosition(LText))
  else if LName = ledPosSpeakerL.Name then
    MarkValidation(ledPosSpeakerL, ValidatePosition(LText))
  else if LName = ledPosSpeakerXL.Name then
    MarkValidation(ledPosSpeakerXL, ValidatePosition(LText))
  else if LName = ledPosReader.Name then
    MarkValidation(ledPosReader, ValidatePosition(LText))
  else if LName = ledPosTable.Name then
    MarkValidation(ledPosTable, ValidatePosition(LText))
  else if LName = ledPosSpeakerReader.Name then
    MarkValidation(ledPosSpeakerReader, ValidatePosition(LText))
  else if LName = ledPosReaderTable.Name then
    MarkValidation(ledPosReaderTable, ValidatePosition(LText))
  else if LName = ledPosTotal.Name then
    MarkValidation(ledPosTotal, ValidatePosition(LText))
  else if LName = ledPosPark.Name then
    MarkValidation(ledPosPark, ValidatePosition(LText));
end;

end.
