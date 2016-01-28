object frmlogin: Tfrmlogin
  Left = 508
  Top = 261
  BorderStyle = bsDialog
  Caption = 'Welcom To SMM'
  ClientHeight = 122
  ClientWidth = 438
  Color = clBtnFace
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
  object btnLogin: TButton
    Left = 320
    Top = 32
    Width = 105
    Height = 57
    Caption = 'Login'
    TabOrder = 0
    OnClick = btnLoginClick
  end
  object grpInfo: TGroupBox
    Left = 8
    Top = 8
    Width = 297
    Height = 105
    Caption = 'Information'
    TabOrder = 1
    object lbl1: TLabel
      Left = 16
      Top = 24
      Width = 59
      Height = 13
      Caption = 'User Name :'
    end
    object lbl2: TLabel
      Left = 16
      Top = 72
      Width = 52
      Height = 13
      Caption = 'Password :'
    end
    object edtUserName: TEdit
      Left = 120
      Top = 24
      Width = 161
      Height = 21
      TabOrder = 0
    end
    object edtPassword: TEdit
      Left = 120
      Top = 64
      Width = 161
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
  end
end
