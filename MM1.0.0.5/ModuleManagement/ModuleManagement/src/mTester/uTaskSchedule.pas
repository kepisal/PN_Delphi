unit uTaskSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmTaskSchedule1 = class(TForm)
    grpSetting: TGroupBox;
    rgOption: TRadioGroup;
    pnlStarting: TPanel;
    lbl2: TLabel;
    dtpDateTime: TDateTimePicker;
    dtpTimePicker: TDateTimePicker;
    cbbBeginTask: TComboBox;
    lbl1: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    grpCheckDay: TGroupBox;
    chkMon: TCheckBox;
    chkTues: TCheckBox;
    chkWed: TCheckBox;
    chkThur: TCheckBox;
    chkFri: TCheckBox;
    chkSat: TCheckBox;
    chkSun: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure rgOptionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTaskSchedule1: TfrmTaskSchedule1;
  DayPicker:String;
  

implementation

{$R *.dfm}

procedure TfrmTaskSchedule1.FormCreate(Sender: TObject);
begin
  chkMon.Enabled:=false;
  chkTues.Enabled:=False;
  chkWed.Enabled:=False;
  chkThur.Enabled:=False;
  chkFri.Enabled:=False;
  chkSat.Enabled:=False;
  chkSun.Enabled:=False;
end;
function getOption(index:Integer):string;
var
  temp:String;
begin
  case index of
  0:temp:='';
  1:temp:='DAILY';
  2:temp:='WEEKLY';
  3:temp:='MONTHLY';
  end;
  Result:=temp;
end;

procedure TfrmTaskSchedule1.btnOkClick(Sender: TObject);
begin

  ShowMessage(getOption(rgOption.ItemIndex));
end;

procedure TfrmTaskSchedule1.rgOptionClick(Sender: TObject);
begin
  if (rgOption.ItemIndex = 2) then
  begin
    chkMon.Enabled:=Enabled;
  chkTues.Enabled:=Enabled;
  chkWed.Enabled:=Enabled;
  chkThur.Enabled:=Enabled;
  chkFri.Enabled:=Enabled;
  chkSat.Enabled:=Enabled;
  chkSun.Enabled:=Enabled;
  end else
  begin
    chkMon.Enabled:=false;
  chkTues.Enabled:=False;
  chkWed.Enabled:=False;
  chkThur.Enabled:=False;
  chkFri.Enabled:=False;
  chkSat.Enabled:=False;
  chkSun.Enabled:=False;
  end;
end;

end.
