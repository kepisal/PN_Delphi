unit iMethod;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ActiveX, StdCtrls, ExtCtrls, ComCtrls, uMethod, Registry,MsHtml,WinInet;

  function getDocumentString(const WebBrowser: TWebBrowser): String;

  procedure waitForNavigate(const Browser: TWebBrowser; lastUrl:String);
  procedure waitForNavigate1(const subStr: String; WebBrowser: TWebBrowser);
  procedure setValue(const att, aID, aValue: String; browser: TWebBrowser);
  procedure doClick(const aID: string; browser: TWebBrowser);
  procedure BlockImage(const block: string = 'yes');

  function FindWebForm(const AWebBrowser: TWebBrowser; const AName: string; out AWebForm: IHTMLFormElement): Boolean;
  function FillWebFormField(const AWebBrowser: TWebBrowser; const AFormName, AFldName, AFldValue: string): Boolean;

  procedure Script(const aScript: string; browser: TWebBrowser);
  procedure setValueBytagIndex(const tagtype, aValue:String; const tagindex: integer; browser: TWebBrowser);
  function WebFormGet(formNumber: integer;document: IHTMLDocument2): IHTMLFormElement;
  procedure WebFormSubmit(const formNumber: integer; browser: TWebBrowser);

  Procedure ClearIECache();
  procedure pageLoading(const subStr: String; WebBrowser: TWebBrowser);
implementation
//-------------------------Star ClearCache Procedure----------------------------
Procedure ClearIECache();
Var
    lpEntryInfo : PInternetCacheEntryInfo;
    hCacheDir   : LongWord;
    dwEntrySize : LongWord;
    dwLastError : LongWord;
Begin
    dwEntrySize := 0;
    FindFirstUrlCacheEntry( NIL, TInternetCacheEntryInfo( NIL^ ), dwEntrySize );
    GetMem( lpEntryInfo, dwEntrySize );
    hCacheDir := FindFirstUrlCacheEntry( NIL, lpEntryInfo^, dwEntrySize );
    If ( hCacheDir = 0 ) Then
        DeleteUrlCacheEntry( lpEntryInfo^.lpszSourceUrlName );
    FreeMem( lpEntryInfo );
    Repeat
        dwEntrySize := 0;
        FindNextUrlCacheEntry( hCacheDir, TInternetCacheEntryInfo( NIL^ ), dwEntrySize );
        dwLastError := GetLastError;
        If ( GetLastError = ERROR_INSUFFICIENT_BUFFER ) Then Begin
            GetMem( lpEntryInfo, dwEntrySize );
            If ( FindNextUrlCacheEntry( hCacheDir, lpEntryInfo^, dwEntrySize ) ) Then
                DeleteUrlCacheEntry( lpEntryInfo^.lpszSourceUrlName );
            FreeMem(lpEntryInfo);
        End;
    Until ( dwLastError = ERROR_NO_MORE_ITEMS );
End;

//-------------------------Start GetDocumentString Function---------------------
function getDocumentString(const WebBrowser: TWebBrowser): String;
var
  LStream: TStringStream;
  Stream: IStream;
  LPersistStreamInit: IPersistStreamInit;
begin
  if not Assigned(WebBrowser.Document) then exit;
  LStream := TStringStream.Create('');
  try
    LPersistStreamInit := WebBrowser.Document as IPersistStreamInit;
    Stream := TStreamAdapter.Create(LStream,soReference);
    LPersistStreamInit.Save(Stream,true);
    result := LStream.DataString;
  finally
    LStream.Free();
  end;
end;

//--------------------Start WaitForNavigate Procedure---------------------------
procedure waitForNavigate(const Browser: TWebBrowser; lastUrl:String);
begin
  //while Browser.ReadyState <> READYSTATE_COMPLETE do
  while (Browser.ReadyState <> READYSTATE_COMPLETE) or (Browser.Busy) do
  begin
    Application.ProcessMessages;
    Sleep(100);
    if lastUrl <> '' then
      if (Browser.LocationURL = lastUrl) and (Browser.ReadyState = READYSTATE_COMPLETE) then break;
  end;
end;

//--------------------Start WaitForNavigate1 Procedure--------------------------
procedure waitForNavigate1(const subStr: String; WebBrowser: TWebBrowser);
begin
  repeat Application.ProcessMessages
  until (PosEx(subStr, getDocumentString(WebBrowser)) > 0);// and (WebBrowser.ReadyState >= READYSTATE_COMPLETE);
end;

//--------------------Start WaitForNavigate1 Procedure--------------------------
procedure pageLoading(const subStr: String; WebBrowser: TWebBrowser);
begin
  repeat Application.ProcessMessages
  until (PosEx(subStr, getDocumentString(WebBrowser)) > 0) and (WebBrowser.ReadyState >= READYSTATE_COMPLETE);
  Sleep(1000);
end;

//-----------------------Start SetValue Procedure-------------------------------
procedure setValue(const att, aID, aValue: String; browser: TWebBrowser);
begin
   browser.OleObject.Document.GetElementByID(aID).setAttribute(att, aValue);
end;

//-----------------------Start DoClick Procedure--------------------------------
procedure doClick(const aID: string; browser: TWebBrowser);
begin
     browser.OleObject.document.GetElementByID(aID).Click;
end;

//-----------------------Start BlockImage Procedure-----------------------------
procedure BlockImage(const block: string);
var
Reg : TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_CURRENT_USER;
  Reg.OpenKey('Software\Microsoft\Internet Explorer\Main', False);

  Reg.WriteString('Display Inline Images', 'yes');
  Reg.Free;
end;

function FindWebForm(const AWebBrowser: TWebBrowser; const AName: string; out AWebForm: IHTMLFormElement): Boolean;
var
  vForms: IHTMLElementCollection;
  vForm : IHTMLFormElement;
  i     : integer;
begin
  Result := False;
  if AWebBrowser.Document=nil then
    Exit;
    
  vForms := (AWebBrowser.Document as IHTMLDocument2).Forms as IHTMLElementCollection;
  for i := 0 to vForms.Length - 1 do
  begin
    vForm := vForms.Item(i, 0) as IHTMLFormElement;
    Result := UpperCase(vForm.name) = UpperCase(AName);
    if Result then
    begin
      AWebForm := vForm;
      Break;
    end;
  end;
end;

function FillWebFormField(const AWebBrowser: TWebBrowser; const AFormName, AFldName, AFldValue: string): Boolean;
var
  vForm: IHTMLFormElement;
  vField: IHTMLElement;
begin
  Result := FindWebForm(AWebBrowser, AFormName, vForm) and (vForm <> nil);
  if Result then
  begin
    vField := vForm.Item(AFldName, '') as IHTMLElement;
    Result := vField <> nil;
    if not Result then
      Exit;

    if vField.tagName = 'INPUT' then
      (vField as IHTMLInputElement).value := AFldValue
    else if vField.tagName = 'SELECT' then
      (vField as IHTMLSelectElement).value := AFldValue
    else if vField.tagName = 'PASSWORD' then
      (vField as IHTMLTextAreaElement).value := AFldValue
    else
      Result := False;
  end;
end;

//----------------------------------------------------------------------------
procedure setValueBytagIndex(const tagtype, aValue:String; const tagindex: integer; browser: TWebBrowser);
var
  ovElements: OleVariant;
  Doc3 :  IHTMLDocument2;
  Element: IHTMLElement;
  Tags : IHTMLElementCollection;
  //TagCount: integer;
begin
  try
    Doc3 := browser.Document as IHTMLDocument2;
    Tags := Doc3.all.Tags(tagtype) as IHTMLElementCollection;
    Element := Tags.Item(tagindex, tagindex) as IHTMLElement;
    if Supports(Element, IHTMLINPUTTextElement) then
      (Element as IHTMLINPUTTextElement).value := aValue;
  except
   on E : Exception do
   begin
     MessageBox(0, PChar(E.Message), '', 0);
   end;
  end;
end;

procedure Script(const aScript: string; browser: TWebBrowser);
begin
  IHTMLDocument2(browser.document).parentWindow.execScript(aScript, 'JavaScript');
end;

//Get Webform by number

function WebFormGet(formNumber: integer;document: IHTMLDocument2): IHTMLFormElement;
var
  forms: IHTMLElementCollection;
begin
  forms := document.Forms as IHTMLElementCollection;
  if formNumber < forms.Length then
    result := forms.Item(formNumber,'') as IHTMLFormElement
  else
    result := nil;
end;


//Submit Form
procedure WebFormSubmit(const formNumber: integer; browser: TWebBrowser);
var
  form : IHTMLFormElement;
  field: IHTMLElement;
  document: IHTMLDocument2;
begin
  form := WebFormGet(formNumber, browser.Document AS IHTMLDocument2);
  form.submit;
end;


end.
