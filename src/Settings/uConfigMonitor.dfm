object FormConfigMonitor: TFormConfigMonitor
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Monitorkonfiguration'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object lblMonitorSelection: TLabel
    Left = 8
    Top = 16
    Width = 89
    Height = 15
    Caption = 'Monitorauswahl:'
  end
  object sgApplications: TStringGrid
    Left = 152
    Top = 253
    Width = 320
    Height = 120
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 326
    Top = 384
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 229
    Top = 384
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
  end
  object cbxMonitorList: TComboBox
    Left = 103
    Top = 13
    Width = 90
    Height = 23
    Style = csDropDownList
    TabOrder = 3
    OnChange = cbxMonitorListChange
  end
end
