unit mProcess;


interface

uses
  Windows, Messages, SysUtils;

  //Execute Multi Module
  procedure _ExecMultiProcess(ProgramName : String; Wait: Boolean); external 'Process.dll'
  //Execute One by one module
  procedure _ExecuteAndWait(const aCommando: string); external 'Process.dll'

implementation
end.
