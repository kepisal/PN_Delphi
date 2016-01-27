program MTester;
{$R *.res}
uses
  Windows,System,StrUtils,SysUtils,uMethod,Seed,
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

function DecryptString(): string;
var
  text, temp,fullFileName,fileini: string;
  F: TextFile;
begin
  fileini:='auto.ini';
  fullFileName:=Application.ExeName;
  fullFileName:=ExtractFilePath(fullFileName)+fileini;
  //ShowMessage(fullFileName);
  AssignFile(F, fullFileName);
  // Reopen the file for reading
  Reset(F);

  // Display the file contents
  while not Eof(F) do
  begin
    ReadLn(F, text);
    temp := temp + text;
  end;
  // Close the file for the last time
  CloseFile(F);
  Result := SeedDecFromBase64(fileini, temp);
end;

begin
  Application.Initialize;
  Application.Title := 'Module Management System';
  if (StrToInt(StrGrab(DecryptString,'[',']'))=0) then
  begin
    Application.CreateForm(Tfrmlogin, frmlogin);
  end;
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
