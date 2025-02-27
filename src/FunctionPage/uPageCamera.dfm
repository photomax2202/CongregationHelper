inherited FormPageCamera: TFormPageCamera
  Caption = 'FormPageCamera'
  ClientHeight = 181
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 220
  TextHeight = 15
  object pnlSpeaker: TPanel
    Left = 0
    Top = 0
    Width = 150
    Height = 90
    BevelOuter = bvNone
    Caption = 'pnlSpeaker'
    ShowCaption = False
    TabOrder = 0
    object pnlSpeakerSize: TPanel
      Left = 0
      Top = 0
      Width = 75
      Height = 90
      BevelOuter = bvNone
      Caption = 'pnlSpeaker'
      ShowCaption = False
      TabOrder = 0
      object btnSpeakerXL: TButton
        Left = 0
        Top = 0
        Width = 75
        Height = 30
        Caption = 'XL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
      end
      object btnSpeakerL: TButton
        Left = 0
        Top = 30
        Width = 75
        Height = 30
        Caption = 'L'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
      end
      object btnSpeakerS: TButton
        Left = 0
        Top = 60
        Width = 75
        Height = 30
        Caption = 'S'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
      end
    end
    object btnSpeaker: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 90
      Caption = 'Redner'
      TabOrder = 1
      TabStop = False
    end
  end
  object btnReader: TButton
    Left = 150
    Top = 0
    Width = 150
    Height = 90
    Caption = 'Leser'
    TabOrder = 1
  end
  object btnTable: TButton
    Left = 300
    Top = 0
    Width = 150
    Height = 90
    Caption = 'Tisch'
    TabOrder = 2
  end
  object btnLeftSpace: TButton
    Left = 0
    Top = 90
    Width = 225
    Height = 40
    Caption = 'btnLeftSpace'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object btnRightSpace: TButton
    Left = 225
    Top = 90
    Width = 225
    Height = 40
    Caption = 'btnRightSpace'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object btnHomePosition: TButton
    Left = 225
    Top = 130
    Width = 225
    Height = 40
    Caption = 'Parkposition'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object btnTotal: TButton
    Left = 0
    Top = 130
    Width = 225
    Height = 40
    Caption = 'Totale'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnCameraClick
  end
end
