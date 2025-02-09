object FormAutoUpdater: TFormAutoUpdater
  Left = 0
  Top = 0
  Caption = 'Auto Updater'
  ClientHeight = 130
  ClientWidth = 525
  Color = clBtnFace
  Constraints.MaxHeight = 169
  Constraints.MaxWidth = 541
  Constraints.MinHeight = 169
  Constraints.MinWidth = 541
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object lbledtAppName: TLabeledEdit
    Left = 80
    Top = 37
    Width = 201
    Height = 23
    EditLabel.Width = 57
    EditLabel.Height = 23
    EditLabel.Caption = 'App Name'
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 0
    Text = ''
  end
  object lbledtRepoName: TLabeledEdit
    Left = 80
    Top = 8
    Width = 201
    Height = 23
    EditLabel.Width = 62
    EditLabel.Height = 23
    EditLabel.Caption = 'Repo Name'
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 1
    Text = ''
  end
  object lbledtAppVersion: TLabeledEdit
    Left = 80
    Top = 66
    Width = 201
    Height = 23
    EditLabel.Width = 63
    EditLabel.Height = 23
    EditLabel.Caption = 'App Version'
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 2
    Text = ''
  end
  object lbledtUrl: TLabeledEdit
    Left = 80
    Top = 95
    Width = 433
    Height = 23
    EditLabel.Width = 21
    EditLabel.Height = 23
    EditLabel.Caption = 'URL'
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 3
    Text = ''
  end
  object btnUpdate: TButton
    Left = 296
    Top = 37
    Width = 217
    Height = 52
    Caption = 'App beenden und neustes Release herunterladen.'
    TabOrder = 4
    WordWrap = True
  end
  object edtAppRunning: TEdit
    Left = 296
    Top = 8
    Width = 217
    Height = 23
    Enabled = False
    TabOrder = 5
    Text = 'edtAppRunning'
  end
  object TimerRefresh: TTimer
    OnTimer = TimerRefreshTimer
    Left = 8
    Top = 96
  end
end
