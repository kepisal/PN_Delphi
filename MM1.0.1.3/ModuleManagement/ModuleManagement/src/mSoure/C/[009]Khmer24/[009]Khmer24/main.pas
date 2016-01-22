unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw,mBase,mTypes,uMethod,MyAgent,StrUtils;

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
  mHost:String='http://www.khmer24.com/';

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

  Uri:=mHost+'/login';

  try
    mAgent.Navigate(Uri);
    mAgent.WaitForNavigateEx(Uri);

    strScript:='document.forms["loginForm"][1].elements["login"].value="'+BASEParam.Items[MPARAM_AXX0101_USERID]+'";'
              +'document.forms["loginForm"][1].elements["password"].value="'+BASEParam.Items[MPARAM_AXX0101_USER_PASSWOED]+'";'
              +'document.forms["loginForm"][1].submit();';

    mAgent.Script(strScript);
    
    strResult:=mAgent.ResultStr;
    uSaveFile('khmer24_login.html',strResult);
  except
    Result:=E_M_FAILTOGETPAGE;
    Exit;
  end;

    Uri:=mHost+'/member/my_account.html';
    mAgent.Navigate(Uri);
    //mAgent.WaitForNavigate('class="welcome"');
    mAgent.WaitForNavigateEx(Uri);

    strResult:=mAgent.ResultStr;

    uSaveFile('khmer24_account.html',strResult);

    if PosEx('title="Log out"',strResult)=0 then
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

   //Uri:=mHost+'/kh/cgi-bin/webscr?cmd=_account';
   try

    BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE] := StrGrab(strResult,'class="control-group">', '>');
    BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE] := StrGrab(BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE],'value="', '"');

    BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION] :=StrGrab(strResult,'class="phone-1 form-input">','>');
    BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION] :=StrGrab(BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION],'value="','"');


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

   mAgent.DoClick('a/href/http://www.khmer24.com/logout.html');
   Result:=S_M_OK;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  APHD:=ParamStr(1);
  Run;
end;

end.
