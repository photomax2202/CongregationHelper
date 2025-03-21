inherited FormConfigGeneral: TFormConfigGeneral
  BorderIcons = []
  Caption = 'Allgemein'
  ClientHeight = 397
  ClientWidth = 420
  Constraints.MaxHeight = 436
  Constraints.MaxWidth = 436
  Constraints.MinHeight = 436
  Constraints.MinWidth = 436
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 436
  ExplicitHeight = 436
  TextHeight = 15
  inherited pnlButtons: TPanel
    Top = 356
    Width = 420
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 356
    ExplicitWidth = 420
    inherited btnOk: TButton
      Left = 226
      ExplicitLeft = 226
    end
    inherited btnCancel: TButton
      Left = 123
      ExplicitLeft = 123
    end
  end
  object ledUrlCheckliste: TLabeledEdit
    Left = 88
    Top = 16
    Width = 324
    Height = 23
    Hint = 'Beginnt mit http:// oder https://'
    EditLabel.Width = 81
    EditLabel.Height = 23
    EditLabel.Caption = 'URL Checkliste:'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = ''
    OnChange = ledFieldValidation
  end
end
