unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw,mBase,mTypes,MyAgent,StrUtils,uMethod;

  function OnInit:HResult;
  function OnParam:HResult;
  function OnLogin:HResult;
  function OnEnter:HResult;
  function OnExcute:HResult;
  function OnResult: HResult;
  function OnFinal:HResult;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mAgent:TMyAgent;

implementation

{$R *.dfm}

Const
  mHost:String='http://www.camhr.com';

var
 Uri,strResult:string;
 strScript:string;

function OnInit:HResult;
begin
  Result:=E_M_UNKNOWN;
  mSetProgress(30);
  try
     Form1.WebBrowser1.Silent:=True;
     mAgent:=TMyAgent.Create(Form1.WebBrowser1);
  except
     Result:=E_M_FAILTOINITCOM;
     Exit;
  end;
  Result:=S_M_OK;

end;

function OnParam:HResult;
begin
  Result:=E_M_UNKNOWN;
  mSetProgress(45);

  if BASEParam.Items[MPARAM_AXX0101_USERID]='' then
  begin
    FLastError:=E_M_USERID_NOTENTER;
    Result:=FLastError;
  end;

  if BASEParam.Items[MPARAM_AXX0101_USER_PASSWOED]='' then
  begin
    FLastError:=E_M_PASSWORD_NOTENTER;
    Result:=FLastError;
  end;

  if mOccurError then Exit;

  Result:=S_M_OK;

end;

function OnLogin:HResult;
begin
  Result:=E_M_UNKNOWN;
  mSetProgress(60);


  //mAgent.Headers := mAgent.Headers + 'Accept: application/json, text/javascript, */*; q=0.01';
  Uri:=mHost+'/login.jsp';

  try
    mAgent.Navigate(Uri);
    mAgent.WaitForNavigateEx(Uri);

    mAgent.SetValue('input/id/name',BASEParam.Items[MPARAM_AXX0101_USERID]);
    mAgent.SetValue('input/id/password',BASEParam.Items[MPARAM_AXX0101_USER_PASSWOED]);
    mAgent.buttonClick('login');

    strResult:=mAgent.ResultStr;
    uSaveFile('camhr_login.html',strResult);
  except
    Result:=E_M_FAILTOGETPAGE;
    Exit;
  end;

    Uri:=mHost+'/pages/user/UserEdit.action';
    mAgent.Navigate(Uri);
    mAgent.WaitForNavigateEx(Uri);

    strResult:=mAgent.ResultStr;

    uSaveFile('camhr_account.html',strResult);

    if PosEx('href="/logout.jsp"',strResult)=0 then
    begin
      FLastError:=E_M_SITE_INVALID;
      Result:=FLastError;
    end;

    if mOccurError then Exit;

  Result:=S_M_OK;
end;

function OnEnter:HResult;
begin
  Result:=E_M_UNKNOWN;
  mSetProgress(70);

  Result:=S_M_OK;
end;

function OnExcute:HResult;
begin
   Result:=E_M_UNKNOWN;
   mSetProgress(80);

   Result:=S_M_OK;
end;

function OnResult: HResult;
begin
  Result:=E_M_UNKNOWN;
   mSetProgress(90);

   try

    BASEResult.Items[MRESULT_AXX0101_ARTICLE_ID] := StrGrab((StrGrab(strResult,'<div class="form-item clear">','</div>',1)),'<label class="form-filed">','</label');
    BASEResult.Items[MRESULT_AXX0101_ARTICLE_ID] := trim(StringReplace(BASEResult.Items[MRESULT_AXX0101_ARTICLE_ID], '&#10003;', '', [rfReplaceAll, rfIgnoreCase]));

    mSetResult;

   except
    Result:=E_M_SITE_INVALID;
    Exit;
   end;


  Result:=S_M_OK;
end;


function OnFinal:HResult;
begin
   Result:=E_M_UNKNOWN;
   mSetProgress(100);

   Result:=S_M_OK;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
    APHD:=ParamStr(1);
    Run;
end;

end.
