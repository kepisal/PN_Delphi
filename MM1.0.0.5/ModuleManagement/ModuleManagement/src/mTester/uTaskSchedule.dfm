object frmTaskSchedule1: TfrmTaskSchedule1
  Left = 600
  Top = 222
  BorderStyle = bsDialog
  Caption = 'Task Schedule'
  ClientHeight = 271
  ClientWidth = 458
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
  object grpSetting: TGroupBox
    Left = 8
    Top = 8
    Width = 441
    Height = 249
    Caption = 'Setting'
    TabOrder = 0
    object lbl1: TLabel
      Left = 8
      Top = 24
      Width = 74
      Height = 13
      Caption = 'Begin the task :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object rgOption: TRadioGroup
      Left = 8
      Top = 48
      Width = 81
      Height = 193
      Items.Strings = (
        'One Time'
        'Daily'
        'Weekly'
        'Monthly')
      TabOrder = 0
      OnClick = rgOptionClick
    end
    object pnlStarting: TPanel
      Left = 96
      Top = 48
      Width = 329
      Height = 161
      TabOrder = 1
      object lbl2: TLabel
        Left = 8
        Top = 16
        Width = 25
        Height = 13
        Caption = 'Start:'
      end
      object dtpDateTime: TDateTimePicker
        Left = 48
        Top = 16
        Width = 121
        Height = 21
        Date = 42384.978932777780000000
        Time = 42384.978932777780000000
        TabOrder = 0
      end
      object dtpTimePicker: TDateTimePicker
        Left = 176
        Top = 16
        Width = 129
        Height = 21
        Date = 42384.978932777780000000
        Time = 42384.978932777780000000
        Kind = dtkTime
        TabOrder = 1
      end
      object grpCheckDay: TGroupBox
        Left = 0
        Top = 56
        Width = 329
        Height = 105
        Caption = 'Multi-option'
        TabOrder = 2
        object chkMon: TCheckBox
          Left = 8
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Monday'
          TabOrder = 0
        end
        object chkTues: TCheckBox
          Left = 72
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Tuesday'
          TabOrder = 1
        end
        object chkWed: TCheckBox
          Left = 144
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Wednesday'
          TabOrder = 2
        end
        object chkThur: TCheckBox
          Left = 232
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Thurday'
          TabOrder = 3
        end
        object chkFri: TCheckBox
          Left = 8
          Top = 64
          Width = 97
          Height = 17
          Caption = 'Friady'
          TabOrder = 4
        end
        object chkSat: TCheckBox
          Left = 72
          Top = 64
          Width = 97
          Height = 17
          Caption = 'Saturday'
          TabOrder = 5
        end
        object chkSun: TCheckBox
          Left = 144
          Top = 64
          Width = 97
          Height = 17
          Caption = 'Sunday'
          TabOrder = 6
        end
      end
    end
    object cbbBeginTask: TComboBox
      Left = 96
      Top = 16
      Width = 329
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        'On a Schedule'
        'At log on'
        'At startup')
    end
    object btnOk: TButton
      Left = 272
      Top = 216
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 3
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 352
      Top = 216
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
    end
  end
end
