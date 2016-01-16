object frmTMR: TfrmTMR
  Left = 605
  Top = 299
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Temporary Module Run'
  ClientHeight = 159
  ClientWidth = 321
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
  object grpTMR_info: TGroupBox
    Left = 7
    Top = 7
    Width = 306
    Height = 143
    Caption = 'Module Information'
    TabOrder = 0
    object lbl1: TLabel
      Left = 30
      Top = 30
      Width = 69
      Height = 13
      Caption = 'Module Code :'
    end
    object lbl2: TLabel
      Left = 30
      Top = 82
      Width = 39
      Height = 13
      Caption = 'Param : '
    end
    object edtTMR_code: TEdit
      Left = 104
      Top = 30
      Width = 137
      Height = 21
      TabOrder = 0
    end
    object edtTMR_param: TEdit
      Left = 104
      Top = 74
      Width = 179
      Height = 21
      TabOrder = 1
      OnDblClick = edtTMR_paramDblClick
    end
    object btnTMR_submit: TButton
      Left = 186
      Top = 111
      Width = 99
      Height = 24
      Caption = 'Run'
      TabOrder = 2
      OnClick = btnTMR_submitClick
    end
    object btnBrowser: TButton
      Left = 248
      Top = 32
      Width = 33
      Height = 17
      Caption = '...'
      TabOrder = 3
      OnClick = btnBrowserClick
    end
  end
end
