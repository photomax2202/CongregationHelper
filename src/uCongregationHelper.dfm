object FormCongregationHelper: TFormCongregationHelper
  Left = 0
  Top = 0
  Caption = 'Congregation Helper'
  ClientHeight = 195
  ClientWidth = 450
  Color = clBtnFace
  Constraints.MaxHeight = 259
  Constraints.MaxWidth = 466
  Constraints.MinHeight = 259
  Constraints.MinWidth = 466
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mpMainMenu
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 450
    Height = 170
    Align = alClient
    TabOrder = 0
    OnChange = pgcMainChange
    ExplicitWidth = 448
    ExplicitHeight = 162
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 170
    Width = 450
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlBottom'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 162
    ExplicitWidth = 448
    object pnlZoomUserStage: TPanel
      Left = 0
      Top = 0
      Width = 100
      Height = 25
      BevelOuter = bvSpace
      Caption = 'B'#252'hne'
      Color = clGray
      ParentBackground = False
      TabOrder = 0
    end
    object pnlZoomUserConference: TPanel
      Left = 106
      Top = 0
      Width = 100
      Height = 25
      BevelOuter = bvSpace
      Caption = 'JW-Conf'
      Color = clGray
      ParentBackground = False
      TabOrder = 1
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
        Caption = 'ZOOM '#252'berwachen'
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
