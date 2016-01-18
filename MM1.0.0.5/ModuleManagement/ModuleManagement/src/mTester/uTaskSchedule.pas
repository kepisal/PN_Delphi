unit uTaskSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, CommCtrl,uMethod;

type
  TfrmTaskSchedule1 = class(TForm)
    grpSetting: TGroupBox;
    rgOption: TRadioGroup;
    pnlStarting: TPanel;
    lbl2: TLabel;
    dtpDateTime: TDateTimePicker;
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
    dtpTime: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure rgOptionClick(Sender: TObject);
    function  createTasks(index:Byte):String;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTaskSchedule1: TfrmTaskSchedule1;
  DayPicker:String;
  

implementation

uses DateUtils;

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

function ConvertTime12To24(Time12:String):String;
var
  zone,temp:String;
  H,M,S:Byte;
begin
  zone:=StrGrab(Time12,' ','');
  H:=StrToInt( copy(Time12,0,StrPos(':',Time12,1)-1));
  temp:= copy(Time12,StrPos(':',Time12,1)+1,StrPos(':',Time12,2));
  if (SameText(zone,'PM')) then
  begin
    if H=12 then
      H:=$00
    else
      H:=H+12;
  end;
  temp:=IntToStr(H)+':'+temp;
end;
function TfrmTaskSchedule1.createTasks(index:Byte):String;
var
  temp,sdate,stime,zone:String;
begin
  
end;
procedure TfrmTaskSchedule1.btnOkClick(Sender: TObject);
var fln:String;
begin
  {fln:=Application.ExeName;
  ShellExecute(0,'runas','schtasks',pansichar('/Create /SC DAILY /TN MTester /TR '+fln+' /ST 22:45'),nil,SW_HIDE);
  Application.Terminate;}
end;

procedure TfrmTaskSchedule1.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

end.
