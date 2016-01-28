program MTester;
{$R *.res}
uses
  Windows,
  System,
  StrUtils,
  SysUtils,
  uMethod,
  Seed,
  uMethododl,
  Forms,
  uTester in 'uTester.pas' {frmScrappingTestApp},
  aResult in 'aResult.pas' {Result},
  mParam in 'mParam.pas' {Param},
  uLogin in 'uLogin.pas' {frmlogin},
  uReadky in 'uReadky.pas' {frmkey},
  AddKey in 'AddKey.pas' {frmAddkey},
  uTMR in 'uTMR.pas' {frmTMR},
  ufrmInformation in 'ufrmInformation.pas' {frmInformation},
  ufrmSignup in 'ufrmSignup.pas' {frmsignup},
  uTaskSchedule in 'uTaskSchedule.pas' {frmTaskSchedule1},
  uMessage in 'uMessage.pas' {frmMsg};

var
  vlu1,vlu2:Integer;
begin
  Application.Initialize;
  Application.Title := 'Module Management System';
  vlu1:=StrToInt(StrGrab(FileDecryption(ExtractFilePath(Application.ExeName)+'auto.ini','auto.ini'),'[',']'));
  vlu2:=StrToInt(StrGrab(FileDecryption(ExtractFilePath(Application.ExeName)+'auto.ini','auto.ini'),'_','_'));
//  if ((vlu1=0) And (vlu2=0)) or ((vlu1=1) And (vlu2=1)) then
  if (vlu1=1) and (vlu2=0) then
  begin
//    Application.CreateForm(Tfrmlogin, frmlogin);
  Application.CreateForm(TfrmScrappingTestApp, frmScrappingTestApp);
  Application.CreateForm(TResult, Result);
  Application.CreateForm(TParam, Param);
  Application.CreateForm(Tfrmkey, frmkey);
  Application.CreateForm(TfrmAddkey, frmAddkey);
  Application.CreateForm(TfrmTMR, frmTMR);
  Application.CreateForm(TfrmInformation, frmInformation);
  Application.CreateForm(Tfrmsignup, frmsignup);
  Application.CreateForm(TfrmTaskSchedule1, frmTaskSchedule1);
  Application.CreateForm(TfrmMsg, frmMsg);
  Application.Minimize;
  end else if(vlu1=0) and (vlu2=1) then begin
  //Application.CreateForm(Tfrmlogin, frmlogin);
  Application.CreateForm(TfrmScrappingTestApp, frmScrappingTestApp);
  Application.CreateForm(TResult, Result);
  Application.CreateForm(TParam, Param);
  Application.CreateForm(Tfrmkey, frmkey);
  Application.CreateForm(TfrmAddkey, frmAddkey);
  Application.CreateForm(TfrmTMR, frmTMR);
  Application.CreateForm(TfrmInformation, frmInformation);
  Application.CreateForm(Tfrmsignup, frmsignup);
  Application.CreateForm(TfrmTaskSchedule1, frmTaskSchedule1);
    Application.CreateForm(TfrmMsg, frmMsg);
  end;
    Application.Run;
end.
