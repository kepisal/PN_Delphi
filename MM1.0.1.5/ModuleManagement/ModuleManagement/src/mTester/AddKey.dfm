object frmAddkey: TfrmAddkey
  Left = 350
  Top = 268
  BorderStyle = bsDialog
  Caption = 'Add Key'
  ClientHeight = 231
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 328
    Height = 217
    Caption = 'Key Definition'
    TabOrder = 0
    object Label1: TLabel
      Left = 22
      Top = 22
      Width = 55
      Height = 13
      Caption = 'Key Code : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 22
      Top = 59
      Width = 75
      Height = 13
      Caption = 'Definition Error :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtKeyCode: TEdit
      Left = 97
      Top = 22
      Width = 209
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object mmoKeyDefin: TMemo
      Left = 22
      Top = 82
      Width = 284
      Height = 97
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btnAddKEy: TButton
      Left = 223
      Top = 186
      Width = 70
      Height = 23
      Caption = 'Submit'
      TabOrder = 2
      OnClick = btnAddKEyClick
    end
  end
end
