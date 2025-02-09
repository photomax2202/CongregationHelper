object FormCongregationHelper: TFormCongregationHelper
  Left = 0
  Top = 0
  Caption = 'Congregation Helper'
  ClientHeight = 200
  ClientWidth = 500
  Color = clBtnFace
  Constraints.MaxHeight = 259
  Constraints.MaxWidth = 516
  Constraints.MinHeight = 259
  Constraints.MinWidth = 516
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
    Width = 500
    Height = 200
    Align = alClient
    TabOrder = 0
  end
  object mpMainMenu: TMainMenu
    Left = 32
    Top = 24
    object mpProgramm: TMenuItem
      Caption = 'Program'
      object mpInfo: TMenuItem
        Caption = 'Info'
      end
      object mpBeenden: TMenuItem
        Caption = 'Beenden'
        OnClick = mpBeendenClick
      end
    end
    object mpSettings: TMenuItem
      Caption = 'Einstellungen'
      object mpAlwaysOnTop: TMenuItem
        Caption = 'Immer im Vordergrund'
        OnClick = mpAlwaysOnTopClick
      end
      object mpSettingsCamera: TMenuItem
        Caption = 'Kameraeinstellungen'
        OnClick = mpSettingsCameraClick
      end
      object mpMonitorSettings: TMenuItem
        Caption = 'Monitoreinstellungen'
        OnClick = mpMonitorSettingsClick
      end
    end
  end
end
