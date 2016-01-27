object frmkey: Tfrmkey
  Left = 525
  Top = 176
  BorderStyle = bsDialog
  Caption = 'Search Key'
  ClientHeight = 438
  ClientWidth = 582
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
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 209
    Height = 98
    Caption = 'Task Performance'
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 52
      Width = 52
      Height = 13
      Caption = 'Key Code :'
    end
    object edtKey: TEdit
      Left = 74
      Top = 52
      Width = 128
      Height = 21
      TabOrder = 0
      OnKeyUp = edtKeyKeyUp
    end
  end
  object GroupBox2: TGroupBox
    Left = 223
    Top = 7
    Width = 350
    Height = 410
    Caption = 'List key'
    TabOrder = 1
    object gridview1: TStringGrid
      Left = 5
      Top = 19
      Width = 338
      Height = 353
      ColCount = 2
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      TabOrder = 0
      OnDblClick = gridview1DblClick
      ColWidths = (
        64
        64)
    end
    object btnAddKEy: TButton
      Left = 267
      Top = 379
      Width = 70
      Height = 23
      Caption = 'Add More'
      TabOrder = 1
      OnClick = btnAddKEyClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 7
    Top = 111
    Width = 209
    Height = 306
    Caption = 'Key definition'
    TabOrder = 2
    object mmdefinition: TMemo
      Left = 7
      Top = 15
      Width = 195
      Height = 283
      TabOrder = 0
    end
  end
end
