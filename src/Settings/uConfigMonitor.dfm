inherited FormConfigMonitor: TFormConfigMonitor
  BorderIcons = []
  Caption = 'Monitorkonfiguration'
  ClientHeight = 337
  ClientWidth = 534
  Constraints.MaxHeight = 376
  Constraints.MaxWidth = 550
  Constraints.MinHeight = 376
  Constraints.MinWidth = 550
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 550
  ExplicitHeight = 376
  TextHeight = 15
  object lblMonitorMedia: TLabel [0]
    Left = 8
    Top = 16
    Width = 86
    Height = 15
    Caption = 'Medienmonitor:'
  end
  object lblMonitorPresentation: TLabel [1]
    Left = 8
    Top = 45
    Width = 117
    Height = 15
    Caption = 'Pr'#228'sentationsmonitor:'
  end
  object lblPrograms: TLabel [2]
    Left = 8
    Top = 80
    Width = 66
    Height = 15
    Caption = 'Programme:'
  end
  inherited pnlButtons: TPanel
    Top = 296
    Width = 534
    TabOrder = 2
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 288
    ExplicitWidth = 532
    inherited btnOk: TButton
      Left = 294
      ExplicitLeft = 293
    end
    inherited btnCancel: TButton
      Left = 202
      ExplicitLeft = 201
    end
  end
  object cbxMonitorMedia: TComboBox
    Left = 143
    Top = 13
    Width = 90
    Height = 23
    Style = csDropDownList
    TabOrder = 0
    OnChange = cbxMonitorListChange
  end
  object cbxMonitorPresentation: TComboBox
    Left = 143
    Top = 42
    Width = 90
    Height = 23
    Style = csDropDownList
    TabOrder = 1
    OnChange = cbxMonitorListChange
  end
  object edtMonitorNameMedia: TEdit
    Left = 239
    Top = 13
    Width = 282
    Height = 23
    ReadOnly = True
    TabOrder = 3
    Text = 'edtMonitorNameMedia'
  end
  object edtMonitorNamePresentation: TEdit
    Left = 239
    Top = 42
    Width = 282
    Height = 23
    ReadOnly = True
    TabOrder = 4
    Text = 'edtMonitorNameMedia'
  end
  object lbPrograms: TListBox
    Left = 8
    Top = 101
    Width = 432
    Height = 180
    ItemHeight = 15
    TabOrder = 5
  end
  object btnProgramUp: TButton
    Left = 446
    Top = 132
    Width = 75
    Height = 25
    Caption = 'hoch >'
    TabOrder = 6
    OnClick = btnProgramUpClick
  end
  object btnProgramTop: TButton
    Left = 446
    Top = 101
    Width = 75
    Height = 25
    Caption = 'hoch >>'
    TabOrder = 7
    OnClick = btnProgramTopClick
  end
  object btnProgramAdd: TButton
    Left = 446
    Top = 163
    Width = 75
    Height = 25
    Caption = 'hinzuf'#252'gen'
    TabOrder = 8
    OnClick = btnProgramAddClick
  end
  object btnProgramDelete: TButton
    Left = 446
    Top = 194
    Width = 75
    Height = 25
    Caption = 'entfernen'
    TabOrder = 9
    OnClick = btnProgramDeleteClick
  end
  object btnProgramDown: TButton
    Left = 446
    Top = 225
    Width = 75
    Height = 25
    Caption = 'runter <'
    TabOrder = 10
    OnClick = btnProgramDownClick
  end
  object btnProgramBottom: TButton
    Left = 446
    Top = 256
    Width = 75
    Height = 25
    Caption = 'runter <<'
    TabOrder = 11
    OnClick = btnProgramBottomClick
  end
end
