unit main;

interface

  function OnInit: HResult;
  function OnParam: HResult;
  function OnLogin: HResult;
  function OnEnter: HResult;
  function OnExcute: HResult;
  function OnResult: HResult;
  function OnFinal: HResult;

implementation

uses
  Windows, mTypes, mBase, SysUtils, uMethod, uWebagent, StrUtils;

const
  mHOST: String = 'https://portal.icepay.com';

var
  mAgent: TWebAgent;
  mUrl, mQuery: String;
  //mStrBlock, mStrItem, mStrTemp: String;
  mResult: String;

function OnInit: HResult;
begin
  Result := E_M_UNKNOWN;
  mSetProgress(30);

  try
    mAgent := TWebAgent.Create;
  except
    Result := E_M_FAILTOINITCOM;
    Exit;
  end;

  Result := S_M_OK;
end;


function OnParam: HResult;
begin
  Result := E_M_UNKNOWN;
  mSetProgress(45);

  {Coding here}
  if BASEParam.Items[MPARAM_AXX0101_USERID] = '' then
  begin
    FLastError := E_M_USERID_NOTENTER;
    Result := FLastError;
  end;
  if BASEParam.Items[MPARAM_AXX0101_USER_PASSWOED] = '' then
  begin
    FLastError := E_M_USERID_NOTENTER;
    Result := FLastError;
  end;
  if mOccurError then exit;

  Result := S_M_OK;
end;


function OnLogin: HResult;
begin
  Result := E_M_UNKNOWN;
  mSetProgress(60);

  mURL := mHost;
  if not mAgent.Connect(mUrl) then begin
    mCheckError(E_M_FAILTOGETPAGE, [False]);
    if mOccurError then exit;
  end;

  mURL := mHost + '/EN/Login';

  mQuery:= 'username='+Trim(BASEParam.Items[MPARAM_AXX0101_USERID])
          +'&password='+Trim(BASEParam.Items[MPARAM_AXX0101_USER_PASSWOED]);


  if not mAgent.Connect(mUrl, mQuery) then begin
    mCheckError(E_M_FAILTOGETPAGE, [False]);
    if mOccurError then exit;
  end;

  mResult := mAgent.ResultStr;
  uSaveFile('icepayMA_login.html',mResult);

  {if PosEx('"status":false', mResult) > 0 then
  begin
    FLastError := E_M_USERID_NOTENTER;
    Result := FLastError;
  end;

  if mOccurError then exit;}

   mURL := mHost + '/Merchant/EN/Reports/Statistics';
   mAgent.Connect(mURL);
   mResult := mAgent.ResultStr;
  if PosEx('<a href="/EN/Login/Logout"',mResult)=0 then
  begin
      FLastError:=E_M_SITE_INVALID;
      Result:=FLastError;
  end;

  if mOccurError then Exit;

  Result := S_M_OK;
end;


function OnEnter: HResult;
begin
  Result := E_M_UNKNOWN;
  mSetProgress(70);

  {Coding here}

  Result := S_M_OK;
end;


function OnExcute: HResult;
begin
  Result := E_M_UNKNOWN;
  mSetProgress(80);

  {Coding here}

  Result := S_M_OK;
end;


function OnResult: HResult;
var
  mIndex, mPage, nPage, nCat, mSession: Integer;
  mStrItem, msPage: String;
  caturl, caturllist : String;
begin
  Result := E_M_UNKNOWN;
  mSetProgress(90);
  uSaveFile('icepayMA_Account.html',mResult);

  BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE] := StrGrab(mResult, '<div id="loginNotice">', '</div>');
  BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE] := trim(StrGrab(BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE],'You are logged in as ',''));

  BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION]:=StrGrab(mResult,'style="float:right">','</')
      +' '+StrGrab(mResult,'style="float:left">','</');

  mSetResult;

  Result := S_M_OK;
end;


function OnFinal: HResult;
begin
  Result := E_M_UNKNOWN;
  mSetProgress(100);

  {Coding here}
  if Assigned(mAgent) then begin
    mAgent.Free;
    mAgent := nil;
  end;

  Result := S_M_OK;
end;

end.


