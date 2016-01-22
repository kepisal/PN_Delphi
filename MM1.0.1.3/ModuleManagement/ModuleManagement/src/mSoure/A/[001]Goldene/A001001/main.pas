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
  mHOST: String = 'https://www.wepay.com';

var
  mAgent: TWebAgent;
  mUrl, mQuery: String;
  mStrBlock, mStrItem, mStrTemp: String;
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

  mURL := mHost + '/dialogs/login_modal';
  if not mAgent.Connect(mUrl) then begin
    mCheckError(E_M_FAILTOGETPAGE, [False]);
    if mOccurError then exit;
  end;
  mResult := mAgent.ResultStr;

  Sleep(5000);

  mURL := mHost + '/session/login';
  mQuery:= 'csrf='      + StrGrab(StrGrab(mResult, 'name="csrf"', '>'), 'value="', '"')
         + '&email='    + Trim(BASEParam.Items[MPARAM_AXX0101_USERID])
         + '&nonce='    + StrGrab(StrGrab(mResult, 'name="nonce"', '>'), 'value="', '"')
         + '&password=' + Trim(BASEParam.Items[MPARAM_AXX0101_USER_PASSWOED])
         ;

  if not mAgent.Connect(mUrl, mQuery) then begin
    mCheckError(E_M_FAILTOGETPAGE, [False]);
    if mOccurError then exit;
  end;
  mResult := mAgent.ResultStr;

  if PosEx('Invalid email or password.', mResult) > 0 then
  begin
    FLastError := E_M_USERID_NOTENTER;
    Result := FLastError;
  end;

  if mOccurError then exit;

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

  BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE] := StrGrab(mResult, 'class="user-email first">', '<');
  BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE] := trim(StringReplace(BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE], '&#10003;', '', [rfReplaceAll, rfIgnoreCase]));

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
