object FormCongregationHelper: TFormCongregationHelper
  Left = 0
  Top = 0
  Caption = 'Congregation Helper'
  ClientHeight = 222
  ClientWidth = 466
  Color = clBtnFace
  Constraints.MaxWidth = 482
  Constraints.MinHeight = 259
  Constraints.MinWidth = 482
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mpMainMenu
  PrintScale = poNone
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 466
    Height = 197
    Align = alClient
    TabOrder = 0
    OnChange = pgcMainChange
    ExplicitWidth = 450
    ExplicitHeight = 170
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 197
    Width = 466
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlBottom'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 170
    ExplicitWidth = 450
    object pnlZoomUserStage: TPanel
      Left = 75
      Top = 0
      Width = 75
      Height = 25
      BevelOuter = bvSpace
      Caption = 'B'#252'hne'
      Color = clGray
      ParentBackground = False
      TabOrder = 0
    end
    object pnlZoomUserConference: TPanel
      Left = 150
      Top = 0
      Width = 75
      Height = 25
      BevelOuter = bvSpace
      Caption = 'JW-Conf'
      Color = clGray
      ParentBackground = False
      TabOrder = 1
    end
    object pnlZoomActive: TPanel
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      BevelOuter = bvSpace
      Caption = 'Zoom'
      Color = clGray
      ParentBackground = False
      TabOrder = 2
    end
  end
  object mpMainMenu: TMainMenu
    Left = 32
    Top = 24
    object mpProgramm: TMenuItem
      Caption = 'Program'
      object mpHelp: TMenuItem
        Caption = 'Hilfe'
        ShortCut = 112
        OnClick = mpProgramClick
      end
      object mpInfo: TMenuItem
        Caption = 'Info'
        ShortCut = 36937
        OnClick = mpProgramClick
      end
      object mpExit: TMenuItem
        Caption = 'Beenden'
        ShortCut = 16499
        OnClick = mpProgramClick
      end
    end
    object mpSettings: TMenuItem
      Caption = 'Einstellungen'
      object mpAlwaysOnTop: TMenuItem
        Caption = 'Immer im Vordergrund'
        OnClick = mpAlwaysOnTopClick
      end
      object mpZoomMonitoring: TMenuItem
        Caption = 'Zoom '#252'berwachen'
        OnClick = mpSettingsClick
      end
      object mpSettingsCamera: TMenuItem
        Caption = 'Kameraeinstellungen'
        OnClick = mpSettingsClick
      end
      object mpSettingsMonitor: TMenuItem
        Caption = 'Monitoreinstellungen'
        OnClick = mpSettingsClick
      end
      object mpPreReleaseRepo: TMenuItem
        Caption = 'Pre-Release Versionen'
        OnClick = mpSettingsClick
      end
    end
  end
  object tmrZoomUser: TTimer
    Interval = 5000
    OnTimer = tmrZoomUserTimer
    Left = 32
    Top = 87
  end
end
