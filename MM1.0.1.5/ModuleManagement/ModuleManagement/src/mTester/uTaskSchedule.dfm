object frmTaskSchedule1: TfrmTaskSchedule1
  Left = 637
  Top = 269
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
    object lbl: TLabel
      Left = 232
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Mail To :'
    end
    object rgOption: TRadioGroup
      Left = 8
      Top = 48
      Width = 81
      Height = 193
      Items.Strings = (
        'One Time'
        'Daily'
        'Weekly')
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
      object Label1: TLabel
        Left = 8
        Top = 72
        Width = 28
        Height = 13
        Caption = 'Day  :'
      end
      object dtpDateTime: TDateTimePicker
        Left = 72
        Top = 16
        Width = 121
        Height = 21
        Date = 42384.978932777780000000
        Time = 42384.978932777780000000
        TabOrder = 0
      end
      object dtpTime: TDateTimePicker
        Left = 200
        Top = 16
        Width = 114
        Height = 21
        Date = 42386.370738182870000000
        Time = 42386.370738182870000000
        Kind = dtkTime
        TabOrder = 1
      end
      object CheckListBox1: TCheckListBox
        Left = 72
        Top = 72
        Width = 241
        Height = 81
        ItemHeight = 13
        Items.Strings = (
          'MONDAY'
          'TUESDAY'
          'WEDNESDAY'
          'THURDAY'
          'FRIDAY'
          'SATURDAY'
          'SUNDAY')
        TabOrder = 2
      end
    end
    object cbbBeginTask: TComboBox
      Left = 96
      Top = 16
      Width = 129
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      OnChange = cbbBeginTaskChange
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
      OnClick = btnCancelClick
    end
    object btnRemoveTask: TButton
      Left = 96
      Top = 216
      Width = 75
      Height = 25
      Caption = 'Remove Task'
      TabOrder = 5
      OnClick = btnRemoveTaskClick
    end
    object edtMailTo: TEdit
      Left = 280
      Top = 16
      Width = 145
      Height = 21
      TabOrder = 6
    end
  end
end
