object Result: TResult
  Left = 256
  Top = 29
  BorderStyle = bsDialog
  Caption = 'Result View'
  ClientHeight = 604
  ClientWidth = 991
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object mResult: TMemo
    Left = -1
    Top = 0
    Width = 993
    Height = 609
    Color = cl3DLight
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ImeName = 'Microsoft IME 2010'
    Lines.Strings = (
      '')
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 896
    Top = 573
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
end
