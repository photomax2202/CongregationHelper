object FormLog: TFormLog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Logfenster'
  ClientHeight = 150
  ClientWidth = 300
  Color = clBtnFace
  Constraints.MaxHeight = 189
  Constraints.MaxWidth = 316
  Constraints.MinHeight = 189
  Constraints.MinWidth = 316
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Scaled = False
  OnCreate = FormCreate
  TextHeight = 15
  object memLog: TMemo
    Left = 0
    Top = 0
    Width = 300
    Height = 150
    Align = alClient
    Lines.Strings = (
      'memLog')
    PopupMenu = mpLog
    ReadOnly = True
    TabOrder = 0
    OnChange = memLogChange
    ExplicitWidth = 298
    ExplicitHeight = 142
  end
  object mpLog: TPopupMenu
    Left = 56
    Top = 48
    object mpReset: TMenuItem
      Caption = 'Reset'
      OnClick = mpResetClick
    end
  end
end
