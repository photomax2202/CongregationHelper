object FormCongregationHelper: TFormCongregationHelper
  Left = 0
  Top = 0
  Caption = 'Congregation Helper'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mpMainMenu
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object mpMainMenu: TMainMenu
    Left = 536
    Top = 312
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
