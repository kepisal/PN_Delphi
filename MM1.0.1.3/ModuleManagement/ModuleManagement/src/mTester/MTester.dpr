program MTester;
{$R *.res}
uses
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
  uTaskSchedule in 'uTaskSchedule.pas' {frmTaskSchedule1};

begin
  Application.Initialize;
  Application.Title := 'Module Management System';
  Application.CreateForm(Tfrmlogin, frmlogin);
  Application.CreateForm(TfrmScrappingTestApp, frmScrappingTestApp);
  Application.CreateForm(TResult, Result);
  Application.CreateForm(TParam, Param);
  Application.CreateForm(Tfrmkey, frmkey);
  Application.CreateForm(TfrmAddkey, frmAddkey);
  Application.CreateForm(TfrmTMR, frmTMR);
  Application.CreateForm(TfrmInformation, frmInformation);
  Application.CreateForm(Tfrmsignup, frmsignup);
  Application.CreateForm(TfrmTaskSchedule1, frmTaskSchedule1);
  Application.Run;
end.
