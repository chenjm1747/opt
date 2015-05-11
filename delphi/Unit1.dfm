object Form1: TForm1
  Left = 615
  Top = 161
  Width = 1305
  Height = 675
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object tmr1: TTimer
    Left = 216
    Top = 72
  end
  object tmr4: TTimer
    Interval = 500
    OnTimer = tmr4Timer
    Left = 312
    Top = 72
  end
  object tmr5: TTimer
    Enabled = False
    Left = 120
    Top = 240
  end
  object tmr6: TTimer
    Enabled = False
    Left = 896
    Top = 112
  end
  object tmr7: TTimer
    Enabled = False
    Left = 16
    Top = 144
  end
  object tmr8: TTimer
    Enabled = False
    Left = 192
    Top = 192
  end
end
