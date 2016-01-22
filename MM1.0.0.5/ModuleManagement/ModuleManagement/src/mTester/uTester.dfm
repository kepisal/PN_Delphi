object frmScrappingTestApp: TfrmScrappingTestApp
  Left = 288
  Top = 130
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Scrape Module Application Management'
  ClientHeight = 586
  ClientWidth = 989
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pAddInfo: TPanel
    Left = 0
    Top = -1
    Width = 985
    Height = 585
    TabOrder = 0
    object gBankInfo: TGroupBox
      Left = 104
      Top = 71
      Width = 641
      Height = 123
      Caption = 'Module Information'
      TabOrder = 0
      object Label18: TLabel
        Left = 52
        Top = 32
        Width = 30
        Height = 13
        Caption = 'Type :'
      end
      object Label19: TLabel
        Left = 48
        Top = 64
        Width = 37
        Height = 13
        Caption = 'Name : '
      end
      object Label21: TLabel
        Left = 360
        Top = 32
        Width = 45
        Height = 13
        Caption = 'Service : '
      end
      object Label22: TLabel
        Left = 338
        Top = 64
        Width = 66
        Height = 13
        Caption = 'Modul Code : '
      end
      object Label23: TLabel
        Left = 19
        Top = 96
        Width = 66
        Height = 13
        Caption = 'Input Param : '
      end
      object edtCatName: TEdit
        Left = 96
        Top = 24
        Width = 201
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 0
      end
      object edtBankName: TEdit
        Left = 96
        Top = 56
        Width = 201
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 1
      end
      object edtService: TEdit
        Left = 416
        Top = 24
        Width = 201
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 2
      end
      object edtModulName: TEdit
        Left = 416
        Top = 56
        Width = 201
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 3
      end
      object edtParam: TEdit
        Left = 96
        Top = 88
        Width = 201
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 4
        OnClick = edtParamClick
      end
    end
    object GroupBox5: TGroupBox
      Left = 768
      Top = 64
      Width = 105
      Height = 124
      TabOrder = 1
      object btn_Save: TButton
        Left = 14
        Top = 24
        Width = 75
        Height = 25
        Caption = 'SAVE'
        TabOrder = 0
        OnClick = btn_SaveClick
      end
      object btnMEdit: TButton
        Left = 15
        Top = 82
        Width = 75
        Height = 23
        Caption = 'EDIT'
        TabOrder = 1
        OnClick = btnMEditClick
      end
    end
    object gbSearch: TGroupBox
      Left = 104
      Top = 22
      Width = 640
      Height = 46
      Caption = 'Search Module'
      TabOrder = 2
      object Label2: TLabel
        Left = 30
        Top = 15
        Width = 72
        Height = 13
        Caption = 'Module Code : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Edt_ModuleCode: TEdit
        Left = 111
        Top = 15
        Width = 299
        Height = 21
        TabOrder = 0
      end
      object btn_Find: TButton
        Left = 423
        Top = 15
        Width = 70
        Height = 23
        Caption = 'Find'
        TabOrder = 1
        OnClick = btn_FindClick
      end
    end
  end
  object pIBXLoad: TPanel
    Left = -1
    Top = -2
    Width = 985
    Height = 585
    TabOrder = 1
    object GroupBox2: TGroupBox
      Left = 12
      Top = 413
      Width = 961
      Height = 161
      Caption = 'Result'
      TabOrder = 0
      object mResult: TMemo
        Left = 8
        Top = 16
        Width = 545
        Height = 137
        Color = clGradientInactiveCaption
        ImeName = 'Microsoft IME 2010'
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object pgExcute: TProgressBar
        Left = 560
        Top = 136
        Width = 385
        Height = 17
        TabOrder = 1
      end
      object mStatus: TMemo
        Left = 560
        Top = 16
        Width = 385
        Height = 105
        Color = clGradientInactiveCaption
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ImeName = 'Microsoft IME 2010'
        Lines.Strings = (
          ' ')
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
    object lvModuleList: TListView
      Left = 12
      Top = 80
      Width = 961
      Height = 297
      BevelInner = bvNone
      BevelOuter = bvNone
      Checkboxes = True
      Columns = <
        item
          Width = 22
        end
        item
          Caption = 'Type'
          Width = 137
        end
        item
          Caption = 'Name'
          Width = 170
        end
        item
          Caption = 'Service'
          Width = 137
        end
        item
          Caption = 'Code'
          Width = 125
        end
        item
          Caption = 'Param'
          Width = 130
        end
        item
          Caption = 'Results'
          Width = 120
        end
        item
          Caption = 'Version'
          Width = 120
        end>
      Ctl3D = False
      GridLines = True
      RowSelect = True
      SortType = stBoth
      TabOrder = 1
      ViewStyle = vsReport
      OnClick = lvModuleListClick
    end
    object GroupBox3: TGroupBox
      Left = 13
      Top = 8
      Width = 353
      Height = 65
      TabOrder = 2
      object btnSearch: TButton
        Left = 263
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Search'
        TabOrder = 0
        OnClick = btnSearchClick
      end
      object edtSearch: TEdit
        Left = 16
        Top = 24
        Width = 233
        Height = 21
        ImeName = 'Microsoft IME 2010'
        TabOrder = 1
        Text = '*'
      end
    end
    object btnStart: TButton
      Left = 880
      Top = 12
      Width = 71
      Height = 60
      Caption = 'Start'
      TabOrder = 3
      OnClick = btnStartClick
    end
    object chModuleCheck: TCheckBox
      Left = 12
      Top = 382
      Width = 81
      Height = 25
      Caption = 'Check All'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveCaptionText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chModuleCheckClick
    end
    object GroupBox1: TGroupBox
      Left = 376
      Top = 8
      Width = 273
      Height = 65
      TabOrder = 5
      object Label1: TLabel
        Left = 128
        Top = 29
        Width = 13
        Height = 13
        Caption = 'To'
      end
      object dtpStart: TDateTimePicker
        Left = 16
        Top = 26
        Width = 97
        Height = 21
        Date = 42345.632665428240000000
        Time = 42345.632665428240000000
        TabOrder = 0
      end
      object dtpEnd: TDateTimePicker
        Left = 160
        Top = 26
        Width = 97
        Height = 21
        Date = 42345.632767951390000000
        Time = 42345.632767951390000000
        TabOrder = 1
      end
    end
    object grpOpiton: TGroupBox
      Left = 656
      Top = 8
      Width = 217
      Height = 66
      Caption = 'Option'
      TabOrder = 6
      object chkMail: TCheckBox
        Left = 8
        Top = 32
        Width = 65
        Height = 17
        Caption = 'Mail To   : '
        TabOrder = 0
        OnClick = chkMailClick
      end
      object edtMail: TEdit
        Left = 80
        Top = 29
        Width = 129
        Height = 21
        TabOrder = 1
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 1192
    Top = 65535
    object File1: TMenuItem
      Caption = 'File'
      object Module1: TMenuItem
        Caption = 'Main Module'
        OnClick = Module1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object AddModuleInfo1: TMenuItem
        Caption = 'Add Module'
        OnClick = AddModuleInfo1Click
      end
      object empModule1: TMenuItem
        Caption = 'Temp Module'
        OnClick = empModule1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object AutoRun1: TMenuItem
        Caption = 'Task Schedule'
        OnClick = AutoRun1Click
      end
      object Keyerror1: TMenuItem
        Caption = 'Key error'
        OnClick = Keyerror1Click
      end
      object version1: TMenuItem
        Caption = 'Version'
        OnClick = version1Click
      end
    end
  end
end
