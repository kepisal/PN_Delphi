program yahooMA;

uses
  Forms,mBase,
  main in 'main.pas';

{$E kha}

{$R *.res}

begin
  Application.Initialize;
  //Application.Run;
  APHD:=ParamStr(1);
  Run;
end.
