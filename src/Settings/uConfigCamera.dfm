object FormConfigCamera: TFormConfigCamera
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Kamerakonfiguration'
  ClientHeight = 340
  ClientWidth = 420
  Color = clBtnFace
  Constraints.MaxHeight = 379
  Constraints.MaxWidth = 436
  Constraints.MinHeight = 379
  Constraints.MinWidth = 436
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object lblPositions: TLabel
    Left = 16
    Top = 168
    Width = 59
    Height = 15
    Caption = 'Positionen:'
  end
  object ledUsername: TLabeledEdit
    Left = 96
    Top = 8
    Width = 313
    Height = 23
    EditLabel.Width = 79
    EditLabel.Height = 23
    EditLabel.Caption = 'Benutzername:'
    LabelPosition = lpLeft
    TabOrder = 0
    Text = ''
    OnChange = ledCredentialsChange
  end
  object ledPassword: TLabeledEdit
    Left = 96
    Top = 37
    Width = 313
    Height = 23
    EditLabel.Width = 50
    EditLabel.Height = 23
    EditLabel.Caption = 'Passwort:'
    LabelPosition = lpLeft
    PasswordChar = '*'
    TabOrder = 1
    Text = ''
    OnChange = ledCredentialsChange
  end
  object ledToken: TLabeledEdit
    Left = 96
    Top = 66
    Width = 313
    Height = 23
    EditLabel.Width = 71
    EditLabel.Height = 23
    EditLabel.Caption = 'Bearer Token:'
    LabelPosition = lpLeft
    TabOrder = 2
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledIP: TLabeledEdit
    Left = 96
    Top = 95
    Width = 313
    Height = 23
    EditLabel.Width = 59
    EditLabel.Height = 23
    EditLabel.Caption = 'IP-Adresse:'
    LabelPosition = lpLeft
    TabOrder = 3
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledMidURL: TLabeledEdit
    Left = 96
    Top = 124
    Width = 313
    Height = 23
    EditLabel.Width = 80
    EditLabel.Height = 23
    EditLabel.Caption = 'URL-Endpunkt:'
    LabelPosition = lpLeft
    TabOrder = 4
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosSpeaker: TLabeledEdit
    Left = 16
    Top = 209
    Width = 60
    Height = 23
    EditLabel.Width = 37
    EditLabel.Height = 15
    EditLabel.Caption = 'Redner'
    TabOrder = 5
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosReader: TLabeledEdit
    Left = 82
    Top = 209
    Width = 60
    Height = 23
    EditLabel.Width = 27
    EditLabel.Height = 15
    EditLabel.Caption = 'Leser'
    TabOrder = 6
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosTable: TLabeledEdit
    Left = 148
    Top = 209
    Width = 60
    Height = 23
    EditLabel.Width = 28
    EditLabel.Height = 15
    EditLabel.Caption = 'Tisch'
    TabOrder = 7
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosSpeakerReader: TLabeledEdit
    Left = 16
    Top = 257
    Width = 89
    Height = 23
    EditLabel.Width = 78
    EditLabel.Height = 15
    EditLabel.Caption = 'Redner + Leser'
    TabOrder = 8
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosReaderTable: TLabeledEdit
    Left = 119
    Top = 257
    Width = 89
    Height = 23
    EditLabel.Width = 69
    EditLabel.Height = 15
    EditLabel.Caption = 'Leser + Tisch'
    TabOrder = 9
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosSpeakerS: TLabeledEdit
    Left = 214
    Top = 257
    Width = 60
    Height = 23
    EditLabel.Width = 46
    EditLabel.Height = 15
    EditLabel.Caption = 'Redner S'
    TabOrder = 10
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosSpeakerL: TLabeledEdit
    Left = 280
    Top = 257
    Width = 60
    Height = 23
    EditLabel.Width = 46
    EditLabel.Height = 15
    EditLabel.Caption = 'Redner L'
    TabOrder = 11
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosSpeakerXL: TLabeledEdit
    Left = 346
    Top = 257
    Width = 60
    Height = 23
    EditLabel.Width = 53
    EditLabel.Height = 15
    EditLabel.Caption = 'Redner XL'
    TabOrder = 12
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosTotal: TLabeledEdit
    Left = 214
    Top = 209
    Width = 60
    Height = 23
    EditLabel.Width = 26
    EditLabel.Height = 15
    EditLabel.Caption = 'Total'
    TabOrder = 13
    Text = ''
    OnChange = ledFieldValidation
  end
  object btnOk: TButton
    Left = 230
    Top = 304
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 14
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 133
    Top = 304
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 15
  end
  object ledPosPark: TLabeledEdit
    Left = 280
    Top = 209
    Width = 60
    Height = 23
    EditLabel.Width = 36
    EditLabel.Height = 15
    EditLabel.Caption = 'Parken'
    TabOrder = 16
    Text = ''
    OnChange = ledFieldValidation
  end
end
