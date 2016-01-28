program pFakeLogin;

uses
  Forms,
  FakeLogin in 'FakeLogin.pas' {frmlogin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrmlogin, frmlogin);
  Application.Run;
end.
