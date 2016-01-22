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

{$E kha}

const
  mHOST: String = 'https://login.yahoo.com';

var
  mAgent: TWebAgent;
  mUrl, mQuery,mCsrf: String;
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

  mURL := mHost +'/?.src=ym&.intl=us&.lang=en-US&.done=https%3a//mail.yahoo.com';
  if not mAgent.Connect(mUrl) then begin
    mCheckError(E_M_FAILTOGETPAGE, [False]);
    if mOccurError then exit;
  end;

  mResult:=mAgent.ResultStr;
  uSaveFile('yahooMa_login.html',mResult);

  mQuery:='username='+Trim(BASEParam.Items[MPARAM_AXX0101_USERID])
          +'&passwd='+ Trim(BASEParam.Items[MPARAM_AXX0101_USER_PASSWOED])
          + '&.persistent='  + StrGrab(StrGrab(mResult, 'name=".persistent"', '>'), 'value="', '"')
          + '&_crumb='       + StrGrab(StrGrab(mResult, 'name="_crumb"', '>'), 'value="', '"')
          + '&_ts='          + StrGrab(StrGrab(mResult, 'name="_ts"', '>'), 'value="', '"')
          + '&_format='      + StrGrab(StrGrab(mResult, 'name="_format"', '>'), 'value="', '"')
          + '&_uuid='        + StrGrab(StrGrab(mResult, 'name="_uuid"', '>'), 'value="', '"')
          + '&_seqid='       + StrGrab(StrGrab(mResult, 'name="_seqid"', '>'), 'value="', '"')
          + '&otp_channel='  + StrGrab(StrGrab(mResult, 'name="otp_channel"', '>'), 'value="', '"')
          ;


  mURL := mHost + StrGrab(StrGrab(mResult, 'id="mbr-login-form"', '>'), 'action="', '"');
  if not mAgent.Connect(mUrl, mQuery) then begin
    mCheckError(E_M_FAILTOGETPAGE, [False]);
    if mOccurError then exit;
  end;

  mResult := mAgent.ResultStr;
  uSaveFile('yahooMA_account.html',mResult);




   if PosEx('>Sign Out<',mResult)=0 then
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

    {BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE] := StrGrab(mResult,'class="control-group">', '>');
    BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE] := StrGrab(BASEResult.Items[MRESULT_AXX0101_ARTICLE_TITLE],'value="', '"');

    BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION] :=StrGrab(mResult,'class="phone-1 form-input">','>');
    BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION] :=StrGrab(BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION],'value="','"');
    }

  mStrBlock := StrGrab(mResult, 'displayNoTransaction("', '")', 1);
  if mStrBlock = '0' then begin
    // No Transaction
    mStrTemp := FormatDateTime('YYYY/MM/DD hh:nn:ss', Now) + ': No Transaction List.';

    BASEResult.Items[MRESULT_AXX0101_ARTICLE_ID]:=BASEResult.Items[MRESULT_AXX0101_ARTICLE_ID]+mStrTemp+'#13#10';

    //mmResponse.Lines.Add(mStrTemp);
  end else begin
    mStrBlock := StrGrab(mResult, '<tbody>', '</tbody>', 3);
    mStrBlock := StringReplace(mStrBlock, '&nbsp;', '', [rfReplaceAll, rfIgnoreCase]);
    mIndex := 1;
    mStrItem := StrGrab(mStrBlock, 'class="msgListItem', '</tr>', mIndex);

    mStrTemp := FormatDateTime('YYYY/MM/DD hh:nn:ss', Now) + ': ';
    //BASEResult.Items[MRESULT_AXX0101_ARTICLE_DATE ]:=mStrTemp;
    BASEResult.Items[MRESULT_AXX0101_ARTICLE_ID]:=BASEResult.Items[MRESULT_AXX0101_ARTICLE_ID]+mStrTemp+'#13#10';

    while mStrItem <> '' do begin
      mStrTemp := 'Item : ' + IntToStr(mIndex) + ' _________________________';
      BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION]:=#13#10+mStrTemp+#13#10+BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION];
      
      mStrTemp := Trim(StrGrab(mStrItem, 'class="mlink', '/a>', 1));   //4
      mStrTemp := Trim(StrGrab(mStrTemp, '">', '<', 1));
      if mStrTemp = '' then mStrTemp := 'null';


      mStrTemp := 'Address : ' + mStrTemp;
      BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION]:=#13#10+mStrTemp+#13#10+BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION];

      mStrTemp := Trim(StrGrab(mStrItem, 'class="mlink', '/a>', 2));
      mStrTemp := Trim(StrGrab(mStrTemp, '">', '<', 1));
      if mStrTemp = '' then mStrTemp := 'null';

      mStrTemp := 'Subject : ' + mStrTemp;
      BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION]:=#13#10+mStrTemp+#13#10+BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION];

      mStrTemp := Trim(StrGrab(mStrItem, '<td class="sortcol">', '</td>', 1));
      if mStrTemp = '' then mStrTemp := 'null';

      mStrTemp := 'Date_Time : ' + mStrTemp;
      BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION]:=#13#10+mStrTemp+#13#10+BASEResult.Items[MRESULT_AXX0101_ARTICLE_DESCRIPTION];

      Inc(mIndex, 1);
      mStrItem := StrGrab(mStrBlock, 'class="msgListItem', '</tr>', mIndex);
    end;
  end;

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



