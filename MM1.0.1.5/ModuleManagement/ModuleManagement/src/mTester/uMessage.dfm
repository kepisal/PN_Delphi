object frmMsg: TfrmMsg
  Left = 599
  Top = 374
  BorderStyle = bsDialog
  Caption = 'Messages'
  ClientHeight = 86
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblcount: TLabel
    Left = 16
    Top = 64
    Width = 27
    Height = 13
    Caption = 'count'
  end
  object pnlMsg: TPanel
    Left = 8
    Top = 8
    Width = 273
    Height = 49
    Caption = 'pnlMsg'
    TabOrder = 0
  end
  object tmrCount: TTimer
    Left = 224
    Top = 72
  end
end
