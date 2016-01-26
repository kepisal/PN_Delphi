unit uTaskSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, CommCtrl,uMethod,shellAPI,
  CheckLst;

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
    dtpTime: TDateTimePicker;
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rgOptionClick(Sender: TObject);
    function  createTasks(index:Byte):String;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbbBeginTaskChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTaskSchedule1: TfrmTaskSchedule1;
  DayPicker:String;
  localTime:TDateTime;

implementation

uses DateUtils, aResult;
var
  TN:String='MTester';
{$R *.dfm}
function getValueComboBox(index:Integer):String;
var
  temp:String;
begin

  case index of
  0 : temp:=' ';
  1 : temp:='ONLOGON';
  //2 : temp:='ONSTART';
  end;
  Result:=temp;
end;

procedure TfrmTaskSchedule1.FormCreate(Sender: TObject);
begin
  CheckListBox1.Enabled:=false;
  rgOption.Enabled:=false;
  dtpDateTime.Enabled:=false;
  dtpTime.Enabled:=false;
  btnOk.Enabled:=False;
end;
function getOption(index:Integer):string;
var
  temp:String;
begin
  temp:=' ';
  case index of
  0:temp:='ONCE';
  1:temp:='DAILY';
  2:temp:='WEEKLY';
  //3:temp:='MONTHLY';
  end;
  Result:=temp;
end;

procedure TfrmTaskSchedule1.rgOptionClick(Sender: TObject);
begin
  if (rgOption.ItemIndex = 2) then
  begin
    CheckListBox1.Enabled:=True;
  end else
  begin
    CheckListBox1.Enabled:=false;
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
      H:=12
    else
    begin H:=H+12;
    temp:=IntToStr(H)+':'+temp; end;
  end else
  begin
    if H<10 then
    begin temp:='0'+IntToStr(H)+':'+temp; end
    else
    begin temp:=IntToStr(H)+':'+temp; end;
  end;
  Result:=temp;
end;
function GetSelectedCheckboxValue(CheckListBox: TCheckListBox): string;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to CheckListBox.Count - 1 do
  begin
    if CheckListBox.Checked[i] then
      Result := Result +Copy(CheckListBox.Items[i],0,3)+',';
  end;
  Result:=copy(Result,0,Length(result)-1);
end;



function TfrmTaskSchedule1.createTasks(index:Byte):String;
var
  temp,sdate,stime,zone,fln,daychecked,Query:String;
  i,j,buttonSelected :Integer;
  test:Cardinal;

begin
  localTime:=Now;
  //temp:=DateToStr(localTime) ;
  fln:=Application.ExeName;
  stime:=ConvertTime12To24(TimeToStr(dtpTime.time));
  sdate:=DateToStr(dtpDateTime.Date);
  //temp:= 'Pisal /p 0231';
  //temp := GetEnvironmentVariable('COMPUTERNAME')+'\'+ GetEnvironmentVariable('USERNAME');

case index of
  0: begin // one time
      Query:='/Create /SC '+getOption(index)+' '+getValueComboBox(cbbBeginTask.ItemIndex)+' /TN "'+TN+'" /TR "'+fln+'" /ST '+stime+' /f';

      end;
  1: begin // DAILY time
      Query:='/Create /SC '+getOption(index)+' /TN "'+TN+'" /TR "'+fln+'" /ST '+stime+' /f';
    end;
  2: begin // WEEKLY time
      Query:='/Create /SC '+getOption(index)+' /D '+GetSelectedCheckboxValue(CheckListBox1)+' /TN "'+TN+'" /TR "'+fln+'" /ST '+stime+' /f';
    end;
  3: begin // ON LOGON
      Query:='/Create /SC '+getValueComboBox(cbbBeginTask.ItemIndex)+' /TN "'+TN+'" /TR "'+fln+'" /f';
    end;
  {4: begin // ONSTART
    Query:='/Create /SC '
            +getValueComboBox(cbbBeginTask.ItemIndex)
            +' /TN "'
            +TN
            +'" /TR "'
            +fln
            +'" /RU Pisal-PC\Pisal'
            +' /RP 0231'
            +' /f';
    Query:='/Create /TN "HOME" /TR "'+fln+'" /SC onstart';
    end;}
  end;
  buttonSelected := messagedlg('Task Updated : '+getValueComboBox(cbbBeginTask.ItemIndex),mtWarning, mbOKCancel, 0);
      if buttonSelected = mrOK then
        begin
         ShellExecute(0,'runas','SchTasks',pansichar(Query),nil,SW_HIDE);
         Result:='Success';
        end;
//end;
end;
procedure TfrmTaskSchedule1.btnOkClick(Sender: TObject);
var
    buttonSelected : Integer;
begin
  case cbbBeginTask.ItemIndex of
  0 : begin ShowMessage(createTasks(rgOption.ItemIndex)); end;
  1 : begin ShowMessage(createTasks(3));end;
  //2 : begin ShowMessage(createTasks(4));end;
  end;
end;

procedure TfrmTaskSchedule1.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmTaskSchedule1.cbbBeginTaskChange(Sender: TObject);
var i:Byte;
begin
  i:=cbbBeginTask.ItemIndex;
  if i= 0 then
  begin
    rgOption.Enabled:=True;
    dtpDateTime.Enabled:=True;
    dtpTime.Enabled:=True;
    btnOk.Enabled:=True;
  end
  else if i = 1 then
  begin
    rgOption.Enabled:=false;
    dtpDateTime.Enabled:=false;
    dtpTime.Enabled:=false;
    CheckListBox1.Enabled:=false;
    btnOk.Enabled:=true;
  end
  else if i = 2 then
  begin
    rgOption.Enabled:=false;
    dtpDateTime.Enabled:=false;
    dtpTime.Enabled:=false;
    CheckListBox1.Enabled:=False;
    btnOk.Enabled:=true;
  end

end;
end.