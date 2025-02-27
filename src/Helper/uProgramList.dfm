object FormProgrammAdd: TFormProgrammAdd
  Left = 0
  Top = 0
  Caption = 'FormProgrammAdd'
  ClientHeight = 211
  ClientWidth = 234
  Color = clBtnFace
  Constraints.MaxHeight = 250
  Constraints.MaxWidth = 250
  Constraints.MinHeight = 250
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object lblProgramCaption: TLabel
    Left = 8
    Top = 61
    Width = 93
    Height = 15
    Caption = 'Programmfenster'
  end
  object lblProgrammMode: TLabel
    Left = 8
    Top = 110
    Width = 94
    Height = 15
    Caption = 'Programmmodus'
  end
  object ledProgramName: TLabeledEdit
    Left = 8
    Top = 32
    Width = 209
    Height = 23
    EditLabel.Width = 90
    EditLabel.Height = 15
    EditLabel.Caption = 'Programmname:'
    TabOrder = 0
    Text = ''
    OnChange = ledProgramNameChange
  end
  object cbxProgramCaption: TComboBox
    Left = 8
    Top = 82
    Width = 209
    Height = 23
    Style = csDropDownList
    Sorted = True
    TabOrder = 1
    OnChange = cbxProgramCaptionChange
  end
  object btnCancel: TButton
    Left = 8
    Top = 168
    Width = 101
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 4
  end
  object btnOk: TButton
    Left = 120
    Top = 168
    Width = 97
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object cbxProgramMode: TComboBox
    Left = 8
    Top = 131
    Width = 209
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'Links Anheften'
    OnChange = cbxProgramModeChange
    Items.Strings = (
      'Links Anheften'
      'Rechts Anheften'
      'Pr'#228'sentation')
  end
end
