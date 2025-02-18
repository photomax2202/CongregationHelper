object FormProgrammAdd: TFormProgrammAdd
  Left = 0
  Top = 0
  Caption = 'FormProgrammAdd'
  ClientHeight = 161
  ClientWidth = 234
  Color = clBtnFace
  Constraints.MaxHeight = 200
  Constraints.MaxWidth = 250
  Constraints.MinHeight = 200
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lblProgramCaption: TLabel
    Left = 8
    Top = 61
    Width = 101
    Height = 15
    Caption = 'lblProgramCaption'
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
    Top = 120
    Width = 101
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
  end
  object btnOk: TButton
    Left = 120
    Top = 120
    Width = 97
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
end
