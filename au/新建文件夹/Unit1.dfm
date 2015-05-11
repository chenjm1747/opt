object Form1: TForm1
  Left = 291
  Top = 162
  Width = 531
  Height = 626
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 168
    Top = 136
    Width = 185
    Height = 89
    Lines.Strings = (
      'mmo1')
    TabOrder = 0
  end
  object idhtp1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 184
    Top = 8
  end
  object IdInterceptThrottler1: TIdInterceptThrottler
    BitsPerSec = 0
    RecvBitsPerSec = 0
    SendBitsPerSec = 0
    Left = 128
    Top = 8
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 72
    Top = 160
  end
end
