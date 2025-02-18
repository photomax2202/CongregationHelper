inherited FormConfigCamera: TFormConfigCamera
  BorderIcons = []
  Caption = 'Kamerakonfiguration'
  ClientHeight = 397
  ClientWidth = 420
  Constraints.MaxHeight = 436
  Constraints.MaxWidth = 436
  Constraints.MinHeight = 436
  Constraints.MinWidth = 436
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 436
  ExplicitHeight = 436
  TextHeight = 15
  object lblPositions: TLabel [0]
    Left = 16
    Top = 168
    Width = 160
    Height = 15
    Caption = 'Positionen (links/mitte/rechts:'
  end
  object lblPositionsOverwiew: TLabel [1]
    Left = 16
    Top = 189
    Width = 175
    Height = 21
    Alignment = taCenter
    Caption = '|--- 1 ---|--- 2 ---|--- 3 ---|'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlButtons: TPanel
    Top = 356
    Width = 420
    TabOrder = 15
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 348
    ExplicitWidth = 418
    inherited btnOk: TButton
      Left = 223
      ExplicitLeft = 222
    end
    inherited btnCancel: TButton
      Left = 120
      ExplicitLeft = 119
    end
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
    Top = 241
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
    Top = 241
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
    Top = 241
    Width = 60
    Height = 23
    EditLabel.Width = 28
    EditLabel.Height = 15
    EditLabel.Caption = 'Tisch'
    TabOrder = 7
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosLeftSpace: TLabeledEdit
    Left = 16
    Top = 321
    Width = 89
    Height = 23
    EditLabel.Width = 71
    EditLabel.Height = 15
    EditLabel.Caption = 'linker Bereich'
    TabOrder = 8
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosRightSpace: TLabeledEdit
    Left = 119
    Top = 321
    Width = 89
    Height = 23
    EditLabel.Width = 79
    EditLabel.Height = 15
    EditLabel.Caption = 'rechter Bereich'
    TabOrder = 9
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosSpeakerS: TLabeledEdit
    Left = 214
    Top = 321
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
    Top = 321
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
    Top = 321
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
    Top = 241
    Width = 60
    Height = 23
    EditLabel.Width = 26
    EditLabel.Height = 15
    EditLabel.Caption = 'Total'
    TabOrder = 13
    Text = ''
    OnChange = ledFieldValidation
  end
  object ledPosPark: TLabeledEdit
    Left = 280
    Top = 241
    Width = 60
    Height = 23
    EditLabel.Width = 36
    EditLabel.Height = 15
    EditLabel.Caption = 'Parken'
    TabOrder = 14
    Text = ''
    OnChange = ledFieldValidation
  end
  object cbxPosSpeaker: TComboBox
    Left = 16
    Top = 270
    Width = 60
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 16
    Text = '1'
    OnChange = cbxPosIndexChange
    Items.Strings = (
      '1'
      '2'
      '3')
  end
  object cbxPosReader: TComboBox
    Left = 82
    Top = 270
    Width = 60
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 17
    Text = '2'
    OnChange = cbxPosIndexChange
    Items.Strings = (
      '1'
      '2'
      '3')
  end
  object cbxPosTable: TComboBox
    Left = 148
    Top = 270
    Width = 60
    Height = 23
    Style = csDropDownList
    ItemIndex = 2
    TabOrder = 18
    Text = '3'
    OnChange = cbxPosIndexChange
    Items.Strings = (
      '1'
      '2'
      '3')
  end
end
