inherited FormPageApplication: TFormPageApplication
  Caption = 'FormPageApplication'
  ClientHeight = 137
  ClientWidth = 450
  Constraints.MaxWidth = 466
  Constraints.MinWidth = 450
  StyleElements = [seFont, seClient, seBorder]
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 466
  ExplicitHeight = 176
  TextHeight = 15
  object pnlBtnLeft: TPanel
    Left = 0
    Top = 0
    Width = 150
    Height = 137
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlBtnLeft'
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 100
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
    Height = 137
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlBtnRight'
    ShowCaption = False
    TabOrder = 1
    ExplicitHeight = 100
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
    Height = 137
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    ExplicitHeight = 100
    object lblBtnPresentation: TLabel
      Left = 8
      Top = 8
      Width = 111
      Height = 15
      Caption = 'Pr'#228'sentatonsmonitor'
    end
  end
end
