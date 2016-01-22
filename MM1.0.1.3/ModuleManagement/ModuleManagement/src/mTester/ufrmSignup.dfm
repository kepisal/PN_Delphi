object frmsignup: Tfrmsignup
  Left = 839
  Top = 246
  BorderStyle = bsDialog
  Caption = 'Sign Up'
  ClientHeight = 182
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grp1: TGroupBox
    Left = 8
    Top = 8
    Width = 297
    Height = 169
    Caption = 'Profile Info'
    TabOrder = 0
    object lbl1: TLabel
      Left = 16
      Top = 32
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
    object lbl3: TLabel
      Left = 16
      Top = 112
      Width = 90
      Height = 13
      Caption = 'Confirm Password :'
    end
    object btnSignUp: TButton
      Left = 208
      Top = 136
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = btnSignUpClick
    end
    object edtUserName: TEdit
      Left = 128
      Top = 24
      Width = 161
      Height = 21
      TabOrder = 1
      OnChange = edtUserNameChange
    end
    object edtPassword: TEdit
      Left = 128
      Top = 64
      Width = 161
      Height = 21
      TabOrder = 2
    end
    object edtCnPssword: TEdit
      Left = 128
      Top = 104
      Width = 161
      Height = 21
      TabOrder = 3
    end
  end
end
