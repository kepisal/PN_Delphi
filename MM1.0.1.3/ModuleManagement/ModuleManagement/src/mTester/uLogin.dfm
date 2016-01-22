object frmlogin: Tfrmlogin
  Left = 1773
  Top = 293
  BorderStyle = bsDialog
  ClientHeight = 230
  ClientWidth = 258
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
  object lblsignup: TLabel
    Left = 186
    Top = 208
    Width = 58
    Height = 16
    Caption = 'Sign Up ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = lblsignupClick
  end
  object Welcom: TGroupBox
    Left = 7
    Top = 7
    Width = 247
    Height = 202
    Caption = 'Welcom'
    TabOrder = 0
    object Label1: TLabel
      Left = 82
      Top = 22
      Width = 74
      Height = 29
      Caption = 'Sign In'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -25
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 82
      Width = 59
      Height = 13
      Caption = 'User Name :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 119
      Width = 52
      Height = 13
      Caption = 'Password :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtUsername: TEdit
      Left = 82
      Top = 82
      Width = 157
      Height = 21
      TabOrder = 0
    end
    object edtPassword: TEdit
      Left = 82
      Top = 119
      Width = 157
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object btnlogin: TButton
      Left = 82
      Top = 156
      Width = 97
      Height = 31
      Caption = 'Log In'
      TabOrder = 2
      OnClick = btnloginClick
    end
  end
end
