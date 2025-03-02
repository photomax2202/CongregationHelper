inherited FormConfigPageSample: TFormConfigPageSample
  BorderIcons = []
  Caption = 'Kamerakonfiguration'
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
    ExplicitTop = 348
    ExplicitWidth = 418
    inherited btnOk: TButton
      Left = 225
      ExplicitLeft = 224
    end
    inherited btnCancel: TButton
      Left = 122
      ExplicitLeft = 121
    end
  end
end
