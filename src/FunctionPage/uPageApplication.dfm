inherited FormPageApplication: TFormPageApplication
  Caption = 'FormPageApplication'
  ClientHeight = 157
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 196
  TextHeight = 15
  object pnlBtnLeft: TPanel
    Left = 0
    Top = 0
    Width = 150
    Height = 129
    BevelOuter = bvNone
    Caption = 'pnlBtnLeft'
    ShowCaption = False
    TabOrder = 0
    object lblBtnLeft: TLabel
      Left = 8
      Top = 7
      Width = 82
      Height = 15
      Caption = 'Links Anheften:'
    end
  end
  object pnlBtnRight: TPanel
    Left = 150
    Top = 0
    Width = 150
    Height = 129
    BevelOuter = bvNone
    Caption = 'pnlBtnRight'
    ShowCaption = False
    TabOrder = 1
    object lblBtnRight: TLabel
      Left = 8
      Top = 8
      Width = 90
      Height = 15
      Caption = 'Rechts Anheften:'
    end
  end
  object pnlBtnPresentation: TPanel
    Left = 300
    Top = 0
    Width = 150
    Height = 129
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    object lblBtnPresentation: TLabel
      Left = 8
      Top = 8
      Width = 114
      Height = 15
      Caption = 'Pr'#228'sentatonsmonitor:'
    end
  end
end
