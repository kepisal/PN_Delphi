unit MyAgent;

interface

uses
  Windows, ActiveX, Variants, SysUtils, StrUtils, Classes, Messages,
  Controls, OleCtrls, ComCtrls, Forms, SHDocVw, MSHTML;

type
  TMyAgent = class

  Private
    {Private variable and method declaration}
    WebBrowser : TWebBrowser;
    Document   : IHtmlDocument2;
    tmpElement : IHTMLInputElement;
    Window     : IHTMLWindow2;
    HTMLVar    : Variant;
    WHandle    : THandle;

  Protected
    {Protect variable and method declaration}
    function GenKeyForCase(CaseValue: string; const RandomKey: Word = 0): Cardinal;
    function GetTagValueEx(const aTagType, aTagName: string; const aElement: IHTMLElement; var aResult: string): Boolean;
    function GetElement(const aQuery: string; const aIndex: Integer): IHTMLElement;

    function _StrPos(const aSubStr, aStr: string; const aIndex: Integer): Integer;
    function _LowerCase(const S: string): string;

    procedure Delay(const aMilliSecond: DWORD);

  Public
    {Public variable and method declaration}

    function WaitForNavigate(const subStr : String) : Boolean;
    function WaitForNavigate1(const lpath : String) : Boolean;

    procedure Connect(const aPath : String; const lDirect : String = ''; const aQuery : String = '');
    procedure Navigate(const aPath : String);
    function ResultStr : String;
    function GetCookie : String;

    function DoClick(const aQuery: string; const aIndex: Integer = 1): Boolean;
    function DoSubmit(const aFormName: string; const aFormIndex: Integer; const aTarget: string = ''): Boolean;

    procedure SetValue(const aQuery, aValue: string; const aIndex: Integer = 1);
    procedure SetValueID(const aID, aValue : String);
    function GetValue(const aQuery : String; const aIndex: Integer = 1) : String;

    function Script(const Script : string): Boolean;
    function SecValue(const basescript, definescript : String):String;

    function StrPos(const aSubStr, aStr: string; const aIndex: Integer = 1; const aCaseSensitive: Boolean = True): Integer;
    function StrReplace(const aStr, aOldStr, aNewStr: string): string;
    function StrGrab(const aStr, aStrPosBegin, aStrPosEnd: String; const aDepth: Integer): String;
    function URLEncode(const aStr: AnsiString): AnsiString;
    procedure DoKeybd_event(const aInput: string; const aDelay: Integer = 100);

    constructor Create(const wp: TWebBrowser); // TWebBrower
    destructor  Destroy; override;

    procedure test();
  end;

implementation

//----------------------------------------------------------------------------//
procedure TMyAgent.test();
var
  wb : TWebBrowser;
begin
  wb := TWebBrowser.Create(nil);
  wb.Navigate('http://www.khmer24.com/');
  //MessageBox(0, PChar('Test'), '', 0);
end;

function TMyAgent.GenKeyForCase(CaseValue: string; const RandomKey: Word = 0): Cardinal;
var
 I, Ln: Cardinal;
begin
 Result := 0;

 Ln := Length(CaseValue);
 if Ln < 1 then Exit;
 for I := 1 to Ln
   do Result := Result + ((Ord(CaseValue[I]) xor (Randomkey * I))) shl ((I and 3) shl 3);

 Result := Result + 1;
end;


function TMyAgent.GetTagValueEx(const aTagType, aTagName: string; const aElement: IHTMLElement; var aResult: string): Boolean;
var
  TagType: string;
begin
  Result := False;
  if not Assigned(aElement) then Exit;
  TagType := LowerCase(aTagType);
  if TagType = '' then Exit;

  case GenKeyForCase(aTagType) of
    $706EDD76: begin  // input
      if not Supports(aElement, IHTMLInputElement) then Exit;
      Result := True;
      case GenKeyForCase(aTagName) of
        $70797466: aResult := string((aElement as IHTMLInputElement).type_);        // type
        $6C61DB76: aResult := string((aElement as IHTMLInputElement).value);        // value
        $6D616E66: aResult := string((aElement as IHTMLInputElement).name);         // name
        $DFD03AE1: aResult := IntToStr((aElement as IHTMLInputElement).maxLength);  // maxlength
        $7A697366: aResult := IntToStr((aElement as IHTMLInputElement).size);       // size
        $746C6101: aResult := string((aElement as IHTMLInputElement).alt);          // alt
        $63727301: aResult := string((aElement as IHTMLInputElement).src);          // src
        $72E1C765: aResult := string((aElement as IHTMLInputElement).border);       // border
        $6469DF75: aResult := IntToStr((aElement as IHTMLInputElement).width);      // width
        $69D9D068: aResult := IntToStr((aElement as IHTMLInputElement).height);     // height
        $00646901: aResult := string(aElement.id);                                  // id        
        else       Result := False;
      end;
    end;
    $6CD9D666: begin  // select
      if not Supports(aElement, IHTMLSelectElement) then Exit;
      Result := True;
      case GenKeyForCase(aTagName) of
        $7A697366: aResult := IntToStr((aElement as IHTMLSelectElement).size);    // size
        $6D616E66: aResult := string((aElement as IHTMLSelectElement).name);      // name
        $7079D366: aResult := string((aElement as IHTMLSelectElement).type_);     // type
        $6C61DB76: aResult := string((aElement as IHTMLSelectElement).value);     // value
        $6ECDE068: aResult := IntToStr((aElement as IHTMLSelectElement).length);  // length
        $00646901: aResult := string(aElement.id);                                // id
        else       Result := False;
      end;
    end;
    $726F666E: begin  // form
      if not Supports(aElement, IHTMLFormElement) then Exit;
      Result := True;
      case GenKeyForCase(aTagName) of
        $74D1D06A: aResult := string((aElement as IHTMLFormElement).action);    // action
        $72696401: aResult := string((aElement as IHTMLFormElement).dir);       // dir
        $D1D7C9D7: aResult := string((aElement as IHTMLFormElement).encoding);  // encoding
        $74C9DC69: aResult := string((aElement as IHTMLFormElement).method);    // method
        $72D5D968: aResult := string((aElement as IHTMLFormElement).target);    // target
        $6D616E66: aResult := string((aElement as IHTMLFormElement).name);      // name
        $6ECDE068: aResult := IntToStr((aElement as IHTMLFormElement).length);  // length
        else       Result := False;
      end;
    end;
    $72D7E36A: begin  // script
      if not Supports(aElement, IHTMLScriptElement) then Exit;
      Result := True;
      case GenKeyForCase(aTagName) of
        $63727301: aResult := string((aElement as IHTMLScriptElement).src);      // src
        $DFE3CE6D: aResult := string((aElement as IHTMLScriptElement).htmlFor);  // htmlfor
        $6576D96F: aResult := string((aElement as IHTMLScriptElement).event);    // event
        $78657475: aResult := string((aElement as IHTMLScriptElement).text);     // text
        $7079D366: aResult := string((aElement as IHTMLScriptElement).type_);    // type
        else       Result := False;
      end;
    end;
    $6261D96D: begin  // table
      if not Supports(aElement, IHTMLTable) then Exit;
      Result := False;
    end;
    $D7C6E272: begin  // marquee
      if not Supports(aElement, IHTMLMarqueeElement) then Exit;
      Result := False;
    end;
    $676D6901: begin  // img
      if not Supports(aElement, IHTMLImgElement) then Exit;
      Result := True;
      case GenKeyForCase(aTagName) of
        $65726867: aResult := string((aElement as IHTMLImgElement).href);      // href
        $72E1C765: aResult := string((aElement as IHTMLImgElement).border);    // border
        $70D8D962: aResult := string((aElement as IHTMLImgElement).vspace);    // vspace
        $70D8CB62: aResult := string((aElement as IHTMLImgElement).hspace);    // hspace
        $746C6101: aResult := string((aElement as IHTMLImgElement).alt);       // alt
        $63727301: aResult := string((aElement as IHTMLImgElement).src);       // src
        $6D616E66: aResult := string((aElement as IHTMLImgElement).name);      // name
        $6469DF75: aResult := IntToStr((aElement as IHTMLImgElement).width);   // width
        $69D9D068: aResult := IntToStr((aElement as IHTMLImgElement).height);  // height
        else       Result := False;
      end;
    end;
    $00006101: begin  // a(Anchor)
      if not Supports(aElement, IHTMLAnchorElement) then Exit;
      Result := True;
      case GenKeyForCase(aTagName) of
        $65726867: aResult := string((aElement as IHTMLAnchorElement).href);      // href
        $72D5D968: aResult := string((aElement as IHTMLAnchorElement).target);    // target
        $6D616E66: aResult := string((aElement as IHTMLAnchorElement).name);      // name
        $736F6875: aResult := string((aElement as IHTMLAnchorElement).host);      // host
        $E0D0D6DA: aResult := string((aElement as IHTMLAnchorElement).hostname);  // hostname
        $E1C2DECE: aResult := string((aElement as IHTMLAnchorElement).pathname);  // pathname
        $726F7075: aResult := string((aElement as IHTMLAnchorElement).port);      // port
        $DED5DFE1: aResult := string((aElement as IHTMLAnchorElement).protocol);  // protocol
        $61CDD673: aResult := string((aElement as IHTMLAnchorElement).search);    // search
        else       Result := False;
      end;
    end;
    $6E696C6C: begin  // link
      if not Supports(aElement, IHTMLLinkElement) then Exit;
      Result := False;
    end;
    $6AD6D266: begin  // object
      if not Supports(aElement, IHTMLObjectElement) then Exit;
      Result := True;
      case GenKeyForCase(aTagName) of
        $00646901: aResult := string(aElement.id);                                // id
        else       Result := False;
      end;
    end;
    else begin
    end;
  end;
end;


function TMyAgent.GetElement(const aQuery: string; const aIndex: Integer): IHTMLElement;
var
  i, MatchCount: Integer;
  TagType, TagName, TagValue, ElementHTML, Temp: string;
  Tags: IHTMLElementCollection;
  Element: IHTMLElement;
begin
  Result := nil;

  Document := WebBrowser.Document as IHTMLDocument2;
  if not Assigned(Document) then Exit;

  TagType  := LowerCase(StrGrab(aQuery, '', '/', 1));
  TagName  := LowerCase(StrGrab(aQuery, '/', '/', 1));
  TagValue := StrGrab(aQuery, '/', '', 2);

  Tags := Document.All.Tags(TagType) as IHTMLElementCollection;
  if not Assigned(Tags) then Exit;

  MatchCount := 0;
  for i := 0 to Tags.Length - 1 do begin
    Element := (Tags.Item(i, i) as IHTMLElement);
    if not Assigned(Element) then begin
      Tags := nil;
      Exit;
    end;
    ElementHTML := string(Element.OuterHTML);

    case GenKeyForCase(TagName) of
      $6C6C6101: begin // all
        if StrPos(TagValue, ElementHTML) > 0 then begin
          MatchCount := MatchCount + 1;
          if MatchCount = aIndex then begin
            Result := Element;
            Break;
          end;
        end;
      end;
      $6C657367: begin // self
        if StrPos(TagValue, StrReplace(ElementHTML, string(Element.InnerHTML), '')) > 0 then begin
          MatchCount := MatchCount + 1;
          if MatchCount = aIndex then begin
            Result := Element;
            Break;
          end;
        end;
      end;
      else begin // another
        if GetTagValueEx(TagType, TagName, Element, Temp) then begin
          if StrPos(TagValue, Temp) > 0 then begin
            MatchCount := MatchCount + 1;
            if MatchCount = aIndex then begin
              Result := Element;
              Break;
            end;
          end;
        end;
      end;
    end;

    Element := nil;
  end;
  if Assigned(Element) then Element := nil;

  Tags := nil;
end;


function TMyAgent._StrPos(const aSubStr, aStr: string; const aIndex: Integer): Integer;
var
  i, j: Integer;
  ResultTemp: Boolean;
begin
  j := 1;
  ResultTemp := False;

  for i := 1 to aIndex do begin
    j := j + (Integer(j <> 1) * Length(aSubStr));
    j := StrUtils.PosEx(aSubStr, aStr, j);
    if (not ResultTemp) and (j > 0) then ResultTemp := True;
  end;

  if ResultTemp then Result := j else Result := 0;
end;


function TMyAgent._LowerCase(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'A') and (Ch <= 'Z') then Inc(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;


function TMyAgent.WaitForNavigate(const subStr : String) : Boolean;
begin
  Result := True;
  repeat Application.ProcessMessages
  until (PosEx(subStr, ResultStr) > 0);
end;


function TMyAgent.WaitForNavigate1(const lpath : String) : Boolean;
begin
  Result := True;
  while (WebBrowser.ReadyState = READYSTATE_COMPLETE) or (WebBrowser.Busy) do
  begin
    Application.ProcessMessages;
    Delay(1000);
    if (WebBrowser.LocationURL=lpath) and (WebBrowser.ReadyState = READYSTATE_COMPLETE) then begin
      break;
    end;
  end;
end;

procedure TMyAgent.Delay(const aMilliSecond: DWORD);
var
  CurrentTick: DWORD;
begin
  CurrentTick := GetTickCount;
  while (GetTickCount - CurrentTick) < aMilliSecond do begin
    Application.ProcessMessages;
    Sleep(0);
  end;
end;


procedure TMyAgent.Connect(const aPath, lDirect, aQuery : String);
var
  i : Integer;
  iElement, eValue, sQuery : String;
begin
  if aQuery <> '' then
  begin
    i := 1;
    sQuery := '&' + aQuery + '&';
    while Trim(StrGrab(StrGrab(sQuery, '&', '&', i), '', '=', 1)) <> '' do
    begin
      iElement  := Trim(StrGrab(StrGrab(sQuery, '&', '&', i), '', '=', 1));
      eValue    := Trim(StrGrab(StrGrab(sQuery, '&', '&', i), '=', '', 1));
      SetValue(iElement, eValue);
      if _LowerCase(StrGrab(iElement, '', '/', 1)) <> 'form' then SetValue(iElement, eValue)
      else DoSubmit(iElement, 1);
      inc(i);
    end;
  end else
  begin
    WebBrowser.Navigate(aPath);
  end;
  WaitForNavigate(aPath);
end;

procedure TMyAgent.Navigate(const aPath : String);
begin
  WebBrowser.Navigate(aPath);
end;

function TMyAgent.ResultStr : String;
var
  LStream: TStringStream;
  Stream : IStream;
  LPersistStreamInit : IPersistStreamInit;
begin
  Result := '';
  if not Assigned(WebBrowser.Document) then exit;
  LStream := TStringStream.Create('');
  try
    LPersistStreamInit := WebBrowser.Document as IPersistStreamInit;
    Stream := TStreamAdapter.Create(LStream,soReference);
    LPersistStreamInit.Save(Stream,true);
    Result := LStream.DataString;
  finally
    LStream.Free();
  end;
end;


function TMyAgent.GetCookie : String;
begin
  Result := '';
  Document := WebBrowser.Document as IHtmlDocument2;
  Result := Document.cookie;
end;


function TMyAgent.DoClick(const aQuery: string; const aIndex: Integer): Boolean;
var
  Element: IHTMLElement;
begin
  Result := False;

  Element := GetElement(aQuery, aIndex);
  if not Assigned(Element) then Exit;

  if Supports(Element, IHTMLAreaElement) then (Element as IHTMLAreaElement).Focus;

  Element.Click;

  Element := nil;
  Result  := True;
end;


function TMyAgent.DoSubmit(const aFormName: string; const aFormIndex: Integer; const aTarget: string): Boolean;
var
  TempForm: IHTMLElement;
begin
  Result := False;

  TempForm := GetElement({'form/name/' +}aFormName, aFormIndex);
  if not Assigned(TempForm) then Exit;

  if aTarget <> '' then (TempForm as IHTMLFormElement).Target := aTarget;
  (TempForm as IHTMLFormElement).Submit;

  Result := True;
end;


procedure TMyAgent.SetValue(const aQuery, aValue: string; const aIndex: Integer = 1);
var
  Element: IHTMLElement;
  IElement : IHTMLInputTextElement;
begin
  Element := GetElement(aQuery, aIndex);
  if not Assigned(Element) then Exit;
  if Supports(Element, IHTMLInputTextElement) then
  begin
    (Element as IHTMLInputTextElement).select;
    IElement := Element as IHTMLInputTextElement;
    IElement.value := aValue;
  end;
end;


procedure TMyAgent.SetValueID(const aID, aValue : String);
begin
  //WebBrowser.OleObject.Document.GetElementByID(aID).setAttribute('Value', aValue);  //TWebBrowser
end;


function TMyAgent.GetValue(const aQuery : String; const aIndex: Integer) : String;
var
  Element: IHTMLElement;
  IElement : IHTMLInputElement;
begin

  Element := GetElement(aQuery, aIndex);
  if not Assigned(Element) then Exit;
  if Supports(Element, IHTMLInputElement) then
  begin
    IElement := Element as IHTMLInputElement;
    Result := IElement.value;
  end;
end;


function TMyAgent.Script(const Script : string): Boolean;
begin
   //WebBrowser.Navigate('about:blank');
   Document := WebBrowser.Document as IHTMLDocument2;
   if not Assigned(Document) then Exit;
   Window := Document.parentWindow;
   if not Assigned(Window) then Exit;
   try
      HTMLVar := Window.execScript(Script, 'JavaScript');
   except
      on E:Exception do raise Exception.Create('Error to invoke javascript: ' + E.Message + ' in: '#13#10 + Script);
   end;
end;


function TMyAgent.SecValue(const basescript, definescript : String) : String;
var
  excuteScript : String;

begin
  Result := '';

  WebBrowser.Navigate('about:blank');
  Document   := WebBrowser.Document as IHtmlDocument2;
  HTMLVar    := VarArrayCreate([0, 0], varVariant);
  HTMLVar[0] := '<HTML>'
                 + '<HEAD></HEAD>'
                 + '<BODY>'
                    + '<script language="javascript" type="text/javascript">'
                       + basescript
                    + '</script>'
                       + '<FORM name="TempForm">'
                          + '<INPUT type="hidden" name="SecVal" id="SecVal" value="" />'
                       + '</FORM>'
                 + '</BODY>'
              + '</HTML>';
  Document.Write(PSafeArray(TVarData(HTMLVar).VArray));

  excuteScript := 'var securedPassword = ' + definescript
                  + 'document.TempForm.SecVal.value = securedPassword;'
                  ;

  Document.parentWindow.execScript(excuteScript, 'JavaScript');
  tmpElement := Document.all.item('SecVal', 0) as IHTMLInputElement;

  Result := tmpElement.value;
end;


function TMyAgent.StrPos(const aSubStr, aStr: string; const aIndex: Integer; const aCaseSensitive: Boolean): Integer;
begin
  if aCaseSensitive then
    Result := _StrPos(aSubStr, aStr, aIndex)
  else
    Result := _StrPos(_LowerCase(aSubStr), _LowerCase(aStr), aIndex)
end;


function TMyAgent.StrReplace(const aStr, aOldStr, aNewStr: string): string;
var
  Temp, TempRes: string;
  aOldStrLength, i: Integer;
begin
  Result := '';
  Temp := aStr;
  aOldStrLength := Length(aOldStr);

  while Temp <> '' do begin
    i := Pos(aOldStr, Temp);
    if i = 0 then Break;
    Result := Result + Copy(Temp, 1, i - 1) + aNewStr;
    Delete(Temp, 1, i + aOldStrLength - 1);
  end;

  if Temp <> '' then Result := Result + Temp;
end;


function TMyAgent.StrGrab(const aStr, aStrPosBegin, aStrPosEnd: String; const aDepth: Integer): String;
var
  mStrDefault, mStrBlock: String;
  mIndex, mPosBegin, mPosEnd: Integer;
begin
  Result := '';
  if aDepth < 1 then Exit;
  mStrDefault := aStr;
  mStrBlock := '';
  if aStrPosBegin = '' then
    mStrBlock := mStrDefault
  else begin
    for mIndex := 0 to aDepth - 1 do begin
      mPosBegin := PosEx(aStrPosBegin, mStrDefault);
      if mPosBegin = 0 then Exit;
      mPosBegin := mPosBegin + Length(aStrPosBegin);
      mPosEnd := Length(mStrDefault) - mPosBegin + 1;
      mStrDefault := Copy(mStrDefault, mPosBegin, mPosEnd);
    end;
  end;
  if aStrPosEnd = '' then
    mStrBlock := mStrDefault
  else begin
    mPosEnd := PosEx(aStrPosEnd, mStrDefault) - 1;
    mStrBlock := Copy(mStrDefault, 1, mPosEnd);
  end;
  Result := mStrBlock;
end;


function TMyAgent.URLEncode(const aStr: AnsiString): AnsiString;
    function AscToHex(const Value: AnsiChar): AnsiString;
    var
        HiNibble, LoNibble: Integer;
    begin
        Result := '';

        HiNibble := Cardinal(Value) div 16;
        LoNibble := Cardinal(Value) mod 16;
        if HiNibble > 9 then
            Result := Result  + Chr((Ord('A') + HiNibble - 10))
        else
            Result := Result  + Chr((Ord('0') + HiNibble));

        if LoNibble > 9 then
            Result := Result  + Chr((Ord('A') + LoNibble - 10))
        else
            Result := Result  + Chr((Ord('0') + LoNibble));
    end;
var
    i: Integer;
begin
    Result := '';

    for i := 1 to Length(aStr) do begin
        case aStr[i] of
            '$', {'&',} '+', ',', '/', ':', ';', {'=',} '?', '@':                  // reserved char
                Result := Result + '%' + AscToHex(aStr[i]);
            ' ', '"', '<', '>', '#', '%', '{', '}', '|', '^', '~', '[', ']', '`':  // unsafety char
                Result := Result + '%' + AscToHex(aStr[i]);
            #128..#255:                                                            // non ascii char
                Result := Result + '%' + AscToHex(aStr[i]);
        else
            Result := Result + aStr[i];
        end;
    end;
end;


procedure TMyAgent.DoKeybd_event(const aInput: string; const aDelay: Integer);
var
  hDocBody: THandle;
  hWBBody: Thandle;
  i, Index, ObjectX, ObjectY: Integer;
  Buff: array[0..255] of Char;
  ch: Char;
begin

  hDOCBody := FindWindowEx(WHandle, 0, 'Shell DocObject View', nil);
  //MessageBox(0,PChar(IntToStr(hDocBody)),'',0);
  if hDOCBody > 0 then begin
  //MessageBox(0,PChar('hello'),'',0);
    hWBBody := FindWindowEx(hDOCBody, 0, 'Internet Explorer_Server', nil);

    FillChar(Buff[0], Length(Buff), #0);
    GetClassName(hWBBody, @Buff[0], Length(Buff));

    FillChar(Buff[0], Length(Buff), #0);
    GetWindowText(hWBBody, @Buff[0], Length(Buff));

    if hWBBody > 0 then begin
      // wbBase.SetFocus;
      for i := 1 to Length(aInput) do begin
        SendMessage(hWBBody, WM_CHAR, Ord(aInput[i]), ((VkKeyScan(aInput[i]) and $000000FF) shl 24) + 1);
        if i = 1 then Delay(aDelay * 2) else Delay(aDelay);

      end;
    end;
  end;
end;


constructor TMyAgent.Create(const wp: TWebBrowser);  // TWebBrower
begin
  try
    WebBrowser := wp;
    //WebBrowser := TWebBrowser.CreateParented(dHandle);
    // TWebBrower
    //WHandle := dHandle;
    {
      WebBrowser.Left := 0;                               // TWebBrower
      WebBrowser.Top := 0;
      WebBrowser.Width := 0;
      WebBrowser.Height := 0;
    }
  except
    Exit;
  end;
end;


destructor TMyAgent.Destroy;
begin
  Document.Close;
  FreeAndNil(WebBrowser);
end;

//----------------------------------------------------------------------------//

end.
