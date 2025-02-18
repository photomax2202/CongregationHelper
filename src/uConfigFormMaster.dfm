object ForrmConfigMaster: TForrmConfigMaster
  Left = 0
  Top = 0
  Caption = 'FormConfigMaster'
  ClientHeight = 441
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlButtons: TPanel
    Left = 0
    Top = 400
    Width = 652
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlButtons'
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = 392
    ExplicitWidth = 650
    DesignSize = (
      652
      41)
    object btnOk: TButton
      Left = 342
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
      ExplicitLeft = 341
    end
    object btnCancel: TButton
      Left = 234
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop]
      Cancel = True
      Caption = 'Abbrechen'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 233
    end
  end
end
