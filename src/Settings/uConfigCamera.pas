unit uConfigCamera;

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
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ExtCtrls,
  uConfig,
  uConfigFormMaster;

type
  TFormConfigCamera = class(TForrmConfigMaster)
    ledUsername: TLabeledEdit;
    ledPassword: TLabeledEdit;
    ledToken: TLabeledEdit;
    ledIP: TLabeledEdit;
    ledMidURL: TLabeledEdit;
    ledPosSpeaker: TLabeledEdit;
    lblPositions: TLabel;
    ledPosReader: TLabeledEdit;
    ledPosTable: TLabeledEdit;
    ledPosLeftSpace: TLabeledEdit;
    ledPosRightSpace: TLabeledEdit;
    ledPosSpeakerS: TLabeledEdit;
    ledPosSpeakerL: TLabeledEdit;
    ledPosSpeakerXL: TLabeledEdit;
    ledPosTotal: TLabeledEdit;
    ledPosPark: TLabeledEdit;
    lblPositionsOverwiew: TLabel;
    cbxPosSpeaker: TComboBox;
    cbxPosReader: TComboBox;
    cbxPosTable: TComboBox;
    ledMidURLSet: TLabeledEdit;
    procedure ledCredentialsChange(Sender: TObject);
    procedure ledFieldValidation(Sender: TObject);
    procedure cbxPosIndexChange(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure DoFormLoad; override;
    procedure DoFormShow; override;
    procedure DoFormSave(out ACanSave: Boolean); override;
  public
    { Public-Deklarationen }
  end;

var
  FormConfigCamera: TFormConfigCamera;

implementation

uses
  uCongregationHelper,
  uValidationAndHelper,
  System.NetEncoding;

{$R *.dfm}

procedure TFormConfigCamera.cbxPosIndexChange(Sender: TObject);

  function GetIndexValues(var AChangedValue: string; var AFirst: string; var ASecond: string): Boolean;
  var
    sl: TStringList;
  begin
    Result := False;
    sl     := TStringList.Create;
    try
      sl.Add('0');
      sl.Add('1');
      sl.Add('2');
      if AChangedValue = AFirst then
      begin
        sl.Delete(sl.IndexOf(AChangedValue));
        sl.Delete(sl.IndexOf(ASecond));
        AFirst := sl.Strings[0];
      end
      else if AChangedValue = ASecond then
      begin
        sl.Delete(sl.IndexOf(AChangedValue));
        sl.Delete(sl.IndexOf(AFirst));
        ASecond := sl.Strings[0];
      end;
      Result := True;
    finally
      sl.Free
    end;

  end;

var
  LSpeakerIndex, LReaderIndex, LTableIndex: String;
begin
  inherited;
  LSpeakerIndex := cbxPosSpeaker.ItemIndex.ToString;
  LReaderIndex  := cbxPosReader.ItemIndex.ToString;
  LTableIndex   := cbxPosTable.ItemIndex.ToString;
  if (Sender as TComboBox).Name = cbxPosSpeaker.Name then
  begin
    if not GetIndexValues(LSpeakerIndex, LReaderIndex, LTableIndex) then
      Exit;
  end
  else if (Sender as TComboBox).Name = cbxPosReader.Name then
  begin

    if not GetIndexValues(LReaderIndex, LSpeakerIndex, LTableIndex) then
      Exit;
  end
  else if (Sender as TComboBox).Name = cbxPosTable.Name then
  begin
    if not GetIndexValues(LTableIndex, LSpeakerIndex, LReaderIndex) then
      Exit;
  end
  else
    Exit;
  cbxPosSpeaker.ItemIndex := LSpeakerIndex.ToInteger;
  cbxPosReader.ItemIndex  := LReaderIndex.ToInteger;
  cbxPosTable.ItemIndex   := LTableIndex.ToInteger;
end;

procedure TFormConfigCamera.DoFormLoad;
begin
  inherited;
  ledUsername.Text := EmptyStr;
  ledPassword.Text := EmptyStr;
  if Config.CameraIp = EmptyStr then
    Config.CameraIp := '0.0.0.0';
  if Config.CameraURL = EmptyStr then
    Config.CameraURL := '';
end;

procedure TFormConfigCamera.DoFormSave(out ACanSave: Boolean);
begin
  inherited;
  ACanSave := False;
  try
    if not ValidateToken(ledToken.Text) then
      Exit;
    if not ValidateIP(ledIP.Text) then
      Exit;
    if not ValidateUrl(ledMidURL.Text) then
      Exit;
    if not ValidateUrl(ledMidURLSet.Text) then
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
    if not ValidatePosition(ledPosLeftSpace.Text) then
      Exit;
    if not ValidatePosition(ledPosRightSpace.Text) then
      Exit;
    if not ValidatePosition(ledPosTotal.Text) then
      Exit;
    if not ValidatePosition(ledPosPark.Text) then
      Exit;
    ACanSave := True;

    Config.CameraToken         := ledToken.Text;
    Config.CameraIp            := ledIP.Text;
    Config.CameraURL           := ledMidURL.Text;
    Config.CameraURLSet        := ledMidURLSet.Text;
    Config.CameraPosSpeaker    := ledPosSpeaker.Text;
    Config.CameraPosSpeakerS   := ledPosSpeakerS.Text;
    Config.CameraPosSpeakerL   := ledPosSpeakerL.Text;
    Config.CameraPosSpeakerXL  := ledPosSpeakerXL.Text;
    Config.CameraPosReader     := ledPosReader.Text;
    Config.CameraPosTable      := ledPosTable.Text;
    Config.CameraPosLeftSpace  := ledPosLeftSpace.Text;
    Config.CameraPosRightSpace := ledPosRightSpace.Text;
    Config.CameraPosTotal      := ledPosTotal.Text;
    Config.CameraPosPark       := ledPosPark.Text;

    Config.CameraPosSpeakerIndex := cbxPosSpeaker.Items[cbxPosSpeaker.ItemIndex];
    Config.CameraPosReaderIndex  := cbxPosReader.Items[cbxPosReader.ItemIndex];
    Config.CameraPosTableIndex   := cbxPosTable.Items[cbxPosTable.ItemIndex];
  finally
    if not ACanSave then
      ShowMessage('Markiertes Feld hat nicht das richtige Format.');
  end;
end;

procedure TFormConfigCamera.DoFormShow;

  procedure GetItemIndexOfPositionIndex(AComboBox: TComboBox; AIndexString: string; ADefault: Integer);
  begin
    if not(AIndexString = EmptyStr) then
      AComboBox.ItemIndex := AComboBox.Items.IndexOf(AIndexString)
    else
      AComboBox.ItemIndex := ADefault;
  end;

begin
  inherited;
  ledToken.Text         := Config.CameraToken;
  ledIP.Text            := Config.CameraIp;
  ledMidURL.Text        := Config.CameraURL;
  ledMidURLSet.Text     := Config.CameraURLSet;
  ledPosSpeaker.Text    := Config.CameraPosSpeaker;
  ledPosSpeakerS.Text   := Config.CameraPosSpeakerS;
  ledPosSpeakerL.Text   := Config.CameraPosSpeakerL;
  ledPosSpeakerXL.Text  := Config.CameraPosSpeakerXL;
  ledPosReader.Text     := Config.CameraPosReader;
  ledPosTable.Text      := Config.CameraPosTable;
  ledPosLeftSpace.Text  := Config.CameraPosLeftSpace;
  ledPosRightSpace.Text := Config.CameraPosRightSpace;
  ledPosTotal.Text      := Config.CameraPosTotal;
  ledPosPark.Text       := Config.CameraPosPark;

  GetItemIndexOfPositionIndex(cbxPosSpeaker, Config.CameraPosSpeakerIndex, 0);
  GetItemIndexOfPositionIndex(cbxPosReader, Config.CameraPosReaderIndex, 1);
  GetItemIndexOfPositionIndex(cbxPosTable, Config.CameraPosTableIndex, 2);
end;

procedure TFormConfigCamera.ledCredentialsChange(Sender: TObject);
var
  Coder: TBase64StringEncoding;
begin
  inherited;
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
  LName: String;
  LText: string;
begin
  inherited;
  LName := (Sender as TLabeledEdit).Name;
  LText := (Sender as TLabeledEdit).Text;
  if LName = ledToken.Name then
    MarkValidation(ledToken, ValidateToken(LText))
  else if LName = ledIP.Name then
    MarkValidation(ledIP, ValidateIP(LText))
  else if LName = ledMidURL.Name then
    MarkValidation(ledMidURL, ValidateUrl(LText))
  else if LName = ledMidURLSet.Name then
    MarkValidation(ledMidURLSet, ValidateUrl(LText))
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
  else if LName = ledPosLeftSpace.Name then
    MarkValidation(ledPosLeftSpace, ValidatePosition(LText))
  else if LName = ledPosRightSpace.Name then
    MarkValidation(ledPosRightSpace, ValidatePosition(LText))
  else if LName = ledPosTotal.Name then
    MarkValidation(ledPosTotal, ValidatePosition(LText))
  else if LName = ledPosPark.Name then
    MarkValidation(ledPosPark, ValidatePosition(LText));
end;

end.
