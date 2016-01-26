{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit uTester;

interface

uses
  Windows, Messages, SysUtils, Forms, Dialogs, Classes, ExtCtrls, Controls,
  IniFiles, StdCtrls, ComCtrls, Menus, uMethod, Seed, mTypes, Grids, ValEdit,
  aResult, mParam, uReadky, ufrmInformation,uWebagent,GetKHAVersion,uMethododl,
  ShellAPI,uTaskSchedule,uYahooMail,EASendMailObjLib_TLB,UTblCreate,CheckLst;

const
  // Send Message Codes to perform each task
  wm_progress = wm_user + $1001;
  wm_error = wm_user + $1002;
  wm_state = wm_user + $1003;
  wm_result = wm_user + $1004;
  wm_start = wm_user + $1005;
  wm_search = wm_user + $1006;
  schar: string = '*/*';

type
  TfrmScrappingTestApp = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Module1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    AddModuleInfo1: TMenuItem;
    pAddInfo: TPanel;
    gBankInfo: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    edtCatName: TEdit;
    edtBankName: TEdit;
    edtService: TEdit;
    edtModulName: TEdit;
    edtParam: TEdit;
    GroupBox5: TGroupBox;
    btn_Save: TButton;
    pIBXLoad: TPanel;
    GroupBox2: TGroupBox;
    mResult: TMemo;
    pgExcute: TProgressBar;
    mStatus: TMemo;
    lvModuleList: TListView;
    GroupBox3: TGroupBox;
    btnSearch: TButton;
    edtSearch: TEdit;
    btnStart: TButton;
    chModuleCheck: TCheckBox;
    GroupBox1: TGroupBox;
    dtpStart: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    Label1: TLabel;
    gbSearch: TGroupBox;
    Label2: TLabel;
    Edt_ModuleCode: TEdit;
    btn_Find: TButton;
    empModule1: TMenuItem;
    Help1: TMenuItem;
    Keyerror1: TMenuItem;
    btnMEdit: TButton;
    version1: TMenuItem;
    AutoRun1: TMenuItem;
    grpOpiton: TGroupBox;
    chkMail: TCheckBox;
    edtMail: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure AddModuleInfo1Click(Sender: TObject);
    procedure Module1Click(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure chModuleCheckClick(Sender: TObject);
    procedure lvModuleListClick(Sender: TObject);
    procedure edtParamClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure Keyerror1Click(Sender: TObject);
    procedure empModule1Click(Sender: TObject);
    procedure btn_FindClick(Sender: TObject);
    procedure btnMEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure version1Click(Sender: TObject);
    procedure AutoRun1Click(Sender: TObject);
    procedure Mail1Click(Sender: TObject);
    procedure chkMailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure _wmReceiveData(var Msg: TWMCopyData); message wm_copydata;
    procedure _wmProgress(var aMessage: TMessage); message wm_progress;
    procedure _wmStatus(var aMessage: TMessage); message wm_state;
    procedure _wmError(var aMessage: TMessage); message wm_error;
    procedure _wmResult(var aMessage: TMessage); message wm_result;
    procedure _wmStart(var aMessage: TMessage); message wm_start;
    procedure _wmSearch(var aMessage: TMessage); message wm_search;
    procedure _ExtractResult();
    procedure _ExecuteAndWait(const aCommando: string);
    function _TemResultString: string;
    procedure _ClearTextBox();
  end;

var
  frmScrappingTestApp: TfrmScrappingTestApp;
  dclDataStr: string;
  dclTemDataStr: array of string;
  dclModuleName: string = '';
  dclRecordIndex: Integer;
  dclI: Integer;

  //Add Information
  dclParam: string;
  dclIniFile: TIniFile;
  dclSection: TStringList;
  dclList: TListItem;

  //Load Param Form
  clsParam: TParam;
  clsResult: TResult;

  // Allow to edit Module
  M_Edit: Boolean=True;
  // Screen Size
  sc_width:Integer;
  sc_height:Integer;

  //Mail
  BodyResult,Mc,Mr,Mv,Md,Mt:String;

  //Table
  DTable:TDrawTable;

implementation

uses
  uTMR;

type
  TBytes = array of Byte;

{$R *.dfm}


procedure TfrmScrappingTestApp._ClearTextBox();
begin
  edtCatName.Clear;
  edtBankName.Clear;
  edtParam.Clear;
  edtService.Clear;
  edtModulName.Clear;
end;
//Recieve Data
procedure TfrmScrappingTestApp._wmReceiveData(var msg: TWMCopyData);
begin
  dclDataStr := PChar(msg.CopyDataStruct.lpData);

    if Pos(M_SDT_RESULT, dclDataStr) <> 0 then
    SendMessage(self.Handle, wm_result, 0, 0);
  if Pos(M_SDT_STATUS, dclDataStr) <> 0 then
    SendMessage(self.Handle, wm_state, 0, 0);
  if Pos(M_SDT_ERROR, dclDataStr) <> 0 then
    SendMessage(self.Handle, wm_error, 0, 0);


end;

//Recieve Progress status
procedure TfrmScrappingTestApp._wmProgress(var aMessage: TMessage);
var
  aProgress: Integer;
begin
  aProgress := aMessage.LParam; // represent a window messages
  pgExcute.Position := aProgress;
end;

//Recieve Module Status
procedure TfrmScrappingTestApp._wmStatus(var aMessage: TMessage);
begin
  if Pos('Start', dclDataStr) <> 0 then
  begin
    dclRecordIndex := 1;
    dclTemDataStr[dclI] := '';
    dclModuleName := lvModuleList.Items.Item[dclI].SubItems[1] + ' ' + lvModuleList.Items.Item[dclI].SubItems[2];
  end;
  Mt:=StrGrab(dclDataStr, M_SDT_STATUS + '[', ']');
  mStatus.Lines.Add(StrGrab(dclDataStr, M_SDT_STATUS + '[', ']'));
end;

//Recieve Module's Error Code
procedure TfrmScrappingTestApp._wmError(var aMessage: TMessage);
begin
  mStatus.Lines.Add(StrGrab(dclDataStr, M_SDT_ERROR + '[', ']'));
  lvModuleList.Items.Item[dclI].SubItems[5] := Trim(StrGrab(dclDataStr, M_SDT_ERROR + '[', ']'));
  mResult.Lines.Add('* [' + lvModuleList.Items.Item[dclI].SubItems[1] + ' ' + lvModuleList.Items.Item[dclI].SubItems[2] + '][' + Trim(StrGrab(dclDataStr, M_SDT_ERROR + '[', ']')) + ']');
end;

//Get Module's Result
procedure TfrmScrappingTestApp._wmResult(var aMessage: TMessage);
//var
  //aData: array of string;
//  sqlQuery, strToday: string;
begin
  _ExtractResult;

  //Set Temporary Data String
  dclTemDataStr[dclI] := dclTemDataStr[dclI] + _TemResultString;
end;

//Precess Execute Module
procedure TfrmScrappingTestApp._wmStart(var aMessage: TMessage);
var
  mExecute, aParam: string;
  isCheck: Boolean;
begin
  DTable:=TDrawTable.create;


  ShowMessage(tfilename);
  DTable.initTbl();
  
  mResult.Lines.Clear;
  mStatus.Lines.Clear;
  isCheck := False;
  Try
  begin
    for dclI := 0 to lvModuleList.Items.Count - 1 do
    begin // loop to execute each *.kha
    if lvModuleList.Items.Item[dclI].Checked then
    begin  // checking item's checked in Module List
      aParam := lvModuleList.Items.Item[dclI].SubItems[4]; // varify value o
      aParam := SeedDecFromBase64('mParam', aParam);
      aParam := StringReplace(aParam, '[DTP-START]', FormatDateTime('yyyymmdd', dtpStart.DateTime), [rfReplaceAll, rfIgnoreCase]);
      aParam := StringReplace(aParam, '[DTP-END]', FormatDateTime('yyyymmdd', dtpEnd.DateTime), [rfReplaceAll, rfIgnoreCase]);
      aParam := SeedEncToBase64('mParam', aParam);

      mExecute := '..\module\' + lvModuleList.Items.Item[dclI].SubItems[3] + '.kha';
        //if the module is not exist then
      lvModuleList.Items.Item[dclI].SubItems[6] :=_GetFileVersion(mExecute);
      if not FileExists(mExecute) then
      begin
          // add the error code to the result column
        lvModuleList.Items.Item[dclI].SubItems[5] := IntToHex(E_M_CODE_NOTEXIST, 8); //'80002F34';
          //  ShowMessage( IntToHex(E_M_CODE_NOTEXIST,8));
      end
        // if exist then execute the module
      else
      begin
                    // A.kha 85569272102 160689


        mExecute := mExecute + ' "' + Trim(Self.Caption) + '"' + ' "' + Trim(aParam) + '"';
        //ShowMessage(mExecute);
        _ExecuteAndWait(mExecute); //Execute one by one



      end;
      isCheck := True;

      Md:=DateTimeToStr(Now);
      Mc:=lvModuleList.Items.Item[dclI].SubItems[3];
      Mr:=lvModuleList.Items.Item[dclI].SubItems[5];
      Mv:=lvModuleList.Items.Item[dclI].SubItems[6];

      //Mt:=StrGrab(dclDataStr, M_SDT_ERROR + '[', ']');
      if Length(Mv)=0 then Mv:='NULL';

      DTable.drawRow(IntToStr(dclI+1),Md,Mc,Mv,Mt,Mr);
      //BodyResult:=BodyResult+'No ['+IntToStr(dclI+1)+'] _ ['+Mc+'] _ ['+Mr+'] _ ['+Mv+'] _ ['+Md+']'+#13#10;
      {BodyResult:=BodyResult+'No ['+IntToStr(dclI+1)+']---'+'['+Md+']----'+'['+Mc+']----'+'['+Mv+']----' +'['+Mt+':'+Mr+']'+#13#10
                  +'----------------------------------------------------------------------'+#13#10;}
      
    end;

    end;
  end
  Except
    ShowMessage('dd');
  End;

  if not isCheck then
    MessageBox(0, PChar('Please choose the module that you want to run!'), '', MB_OK + MB_ICONINFORMATION);
end;
{procedure TfrmScrappingTestApp._wmStart(var aMessage: TMessage);
var
  mExecute, aParam: String;
  isCheck: Boolean;
begin
  mResult.Lines.Clear;
  mStatus.Lines.Clear;
  isCheck := False;
  for dclI := 0 to lvModuleList.Items.Count - 1 do begin // loop to execute each *.kha
      if lvModuleList.Items.Item[dclI].Checked then begin  // checking item's checked in Module List
        aParam := lvModuleList.Items.Item[dclI].SubItems[4]; // varify value o
        aParam := SeedDecFromBase64('mParam', aParam);
        aParam := StringReplace(aParam, '[DTP-START]', FormatDateTime('yyyymmdd', dtpStart.DateTime), [rfReplaceAll, rfIgnoreCase]);
        aParam := StringReplace(aParam, '[DTP-END]', FormatDateTime('yyyymmdd', dtpEnd.DateTime), [rfReplaceAll, rfIgnoreCase]);
        aParam := SeedEncToBase64('mParam', aParam);

        mExecute := '..\module\' + lvModuleList.Items.Item[dclI].SubItems[3] + '.kha';
        mExecute := mExecute + ' "' + Trim(Self.Caption) + '"' + ' "' + Trim(aParam) + '"';
        _ExecuteAndWait(mExecute); //Execute one by one
        isCheck := True;
      end;
  end;
  if not isCheck then MessageBox(0, PChar('Please choose the module that you want to run!'), '', MB_OK + MB_ICONINFORMATION);
end;}

//Process Search for Module

procedure TfrmScrappingTestApp._wmSearch(var aMessage: TMessage);
var
  dclKeyword, dclMName, dclSMName: string;
  dclFilePart: string;
begin
  dclList := TListItem.Create(nil);
  dclFilePart := ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg';

  //Check File Exist
  if not FileExists(dclFilePart) then
  begin
  end
  else
  begin
    dclIniFile := TIniFile.Create(dclFilePart);
    dclSection := TStringList.Create;
    dclIniFile.ReadSections(dclSection);

    if dclSection.IndexOf('Modul') < 0 then
    begin
      dclKeyword := edtSearch.Text;
      lvModuleList.Items.Clear;

      for dclI := 0 to dclSection.Count - 1 do
      begin
        dclMName := dclIniFile.ReadString('Modul' + IntToStr(dclI), 'Modul_Name', '');
        dclSMName := Copy(dclMName, 1, Length(dclKeyword));

        if (dclSMName = dclKeyword) or (dclKeyword = '*') then
        begin
          dclParam := dclIniFile.ReadString('Modul' + IntToStr(dclI), 'ModuleInfo', '');
          dclParam := SeedDecFromBase64('ModuleInfo', dclParam);
          dclList := lvModuleList.Items.Add;
          with dclList.SubItems do
          begin
            Add(StrGrab(dclParam, schar, schar, 1));
            Add(StrGrab(dclParam, schar, schar, 2));
            Add(StrGrab(dclParam, schar, schar, 3));
            Add(StrGrab(dclParam, schar, schar, 4));
            Add(StrGrab(dclParam, schar, schar, 5)); // data encrypted
            Add(''); // result
            Add(''); // version
          end;
        end;
      end;
      SetLength(dclTemDataStr, lvModuleList.Items.Count);
    end;
  end;
end;

//Format of Display Module's Result
function TfrmScrappingTestApp._TemResultString: string;
begin
  with BASEResult do begin
  Result := '[' + dclModuleName + '] ' + ' [' + IntToStr(dclRecordIndex) + ']'        + #13#10
          + '***********************************************************************'
          + '***********************************************************************' + #13#10
          + '- 01 : ' + Items[1] + #13#10
          + '- 02 : ' + Items[2] + #13#10
          + '- 03 : ' + Items[3] + #13#10
          + '- 04 : ' + Items[4] + #13#10
          + '- 05 : ' + Items[5] + #13#10
          + '- 06 : ' + Items[6] + #13#10
          + '- 07 : ' + Items[7] + #13#10
          + '- 08 : ' + Items[8] + #13#10
          + '- 09 : ' + Items[9] + #13#10
          + '- 10 : ' + Items[10] + #13#10
          + '- 11 : ' + Items[11] + #13#10
          + '- 12 : ' + Items[12] + #13#10
          + '- 13 : ' + Items[13] + #13#10
          + '- 14 : ' + Items[14] + #13#10
          + '- 15 : ' + Items[15] + #13#10
          + '- 16 : ' + Items[16] + #13#10
          + '- 17 : ' + Items[17] + #13#10
          + '- 18 : ' + Items[18] + #13#10
          + '- 19 : ' + Items[19] + #13#10
          + '- 20 : ' + Items[20] + #13#10
          + '***********************************************************************'
          + '***********************************************************************' + #13#10
          ;
  end;
  inc(dclRecordIndex);
end;

//Exstract Module's Result
procedure TfrmScrappingTestApp._ExtractResult();
var
  i: Integer;
begin
  i := 1;
  while i < M_MAXPARAM do
  begin
    BASEResult.Items[i] := StrGrab(dclDataStr, 'Result' + IntToStr(i) + '=', 'Result');
    inc(i);
  end;
end;

//Save Module Info to Ini File
procedure TfrmScrappingTestApp.btn_SaveClick(Sender: TObject);
var
  dclBInfo: String;
  dclLastSection: String;
begin
  if not DirectoryExists(ExtractFilePath(ParamStr(0)) + 'Logs\') then
    if not CreateDir(ExtractFilePath(ParamStr(0)) + 'Logs\') then;

    dclBInfo := schar + edtCatName.Text
            + schar + edtBankName.Text
            + schar + edtService.Text
            + schar + edtModulName.Text
            + schar + edtParam.Text
            + schar;
  dclParam := SeedEncToBase64('ModuleInfo', dclBInfo);
  //Update Module Info
  if(M_Edit=False) then
  begin
  if FileExists(ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg') then
  begin
    dclIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg');
    dclSection := TStringList.Create;
    dclIniFile.ReadSections(dclSection);
    dclLastSection := IntToStr(dclI);
    dclIniFile.WriteString('Modul' + dclLastSection, 'Modul_Name', Trim(Edt_ModuleCode.Text));
    dclIniFile.WriteString('Modul' + dclLastSection, 'ModuleInfo', dclParam);
    dclIniFile.UpdateFile;
    ShowMessage('Update Completed');
  end;
  end
  else
    begin // Add New Module
  //Save Encrypted Account Info
  if FileExists(ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg') then
  begin
    dclIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg');
    dclSection := TStringList.Create;
    dclIniFile.ReadSections(dclSection);
    dclLastSection := IntToStr(dclSection.Count);
    dclIniFile.WriteString('Modul' + dclLastSection, 'Modul_Name', Trim(edtModulName.Text));
    dclIniFile.WriteString('Modul' + dclLastSection, 'ModuleInfo', dclParam);
    dclIniFile.UpdateFile;
    ShowMessage('Insert Completed');
  end else begin
    dclIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg');
    dclIniFile.WriteString('Modul0', 'Modul_Name', Trim(edtModulName.Text));
    dclIniFile.WriteString('Modul0', 'ModuleInfo', dclParam);

    ShowMessage('Insert Completed');
  end;
      end;
      _ClearTextBox();
end;

//Execute One by one module
procedure TfrmScrappingTestApp._ExecuteAndWait(const aCommando: string);
var
  tmpStartupInfo: TStartupInfo;
  tmpProcessInformation: TProcessInformation;
  tmpProgram: string;
begin
  tmpProgram := trim(aCommando);
  FillChar(tmpStartupInfo, SizeOf(tmpStartupInfo), 0);
  with tmpStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    wShowWindow := SW_HIDE;
  end;

  if CreateProcess(nil, pchar(tmpProgram), nil, nil, true, CREATE_NO_WINDOW, nil, nil, tmpStartupInfo, tmpProcessInformation) then
  begin
    // loop every 10 ms
    while WaitForSingleObject(tmpProcessInformation.hProcess, 10) > 0 do
    begin
      Application.ProcessMessages;
    end;
    CloseHandle(tmpProcessInformation.hProcess);
    CloseHandle(tmpProcessInformation.hThread);
  end
  else
  begin
    RaiseLastOSError;
  end;
end;

//Search for module
procedure TfrmScrappingTestApp.btnSearchClick(Sender: TObject);
var
  connectTO:TWebAgent;
begin
  connectTO:=TWebAgent.Create();
  connectTO.Connect('https://www.google.com');
  if (connectTO.ResultStr <> EmptyStr)  then
  begin
  SendMessage(self.Handle, wm_search, 0, 0);
  end else begin
    ShowMessage('Network Invalid');
  end;
end;

//Run module
procedure TfrmScrappingTestApp.btnStartClick(Sender: TObject);
var
  success,i:Integer;
  T:UTF8String;
  UTS:TStrings;
  sent:Boolean;
begin
  success:=  SendMessage(self.Handle, wm_start, 0, 0);

  DTable.saveToFile;
  if success = 0 then
  begin
    if (chkMail.Checked) and (Length(edtMail.Text)>0) then
    begin
        sent:=sendMail('scrape3rd@yahoo.com',edtMail.Text,'Module Process on '+DateTimeToStr(now),'Information store in attach file','scrape3rd@yahoo.com','G_3rdscrape',tfilename);
        end;

        //ShowMessage(T);
        if (sent) then
          ShowMessage('Sending Completed')
        else
          ShowMessage('Sending Fail');
    end;
  end;
  //else MessageDlg('Execute Fail...',mtError,mbOKCancel,0);
  //ShowMessage(T);


//end;

procedure TfrmScrappingTestApp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Application.Terminate();
end;

procedure TfrmScrappingTestApp.AddModuleInfo1Click(Sender: TObject);
begin
  edtCatName.Enabled := True;
  edtBankName.Enabled := True;
  edtService.Enabled := True;
  edtParam.Enabled := True;
  edtModulName.Enabled := True;

  pAddInfo.Visible := true;
  pIBXLoad.Visible := false;
end;

procedure TfrmScrappingTestApp.Module1Click(Sender: TObject);
begin
  pAddInfo.Visible := false;
  pIBXLoad.Visible := true;
end;

procedure TfrmScrappingTestApp.chModuleCheckClick(Sender: TObject);
var
  i: integer;
  b: boolean;
begin
  b := false;
  if chModuleCheck.Checked = true then
    b := true
  else
    b := false;
  for i := 0 to lvModuleList.Items.Count - 1 do
  begin
    lvModuleList.Items[i].Checked := b;
  end;
end;

procedure TfrmScrappingTestApp.lvModuleListClick(Sender: TObject);
const
  LparamCol = 62;
  RparamCol = 75;
  RResultCol = 88;
var
  pt: TPoint;
  keyerr: string;
  i,lvw,paramPoint: integer;
begin
  try
    pt := lvModuleList.ScreenToClient(mouse.cursorpos);
    lvw := lvModuleList.Width;
    paramPoint := Round((pt.x * 100) / lvw);
    if lvModuleList.Items.Count > 0 then
    begin
      if (paramPoint > LparamCol) and (paramPoint < RparamCol) then  // Param Col
       begin
        clsParam := TParam.Create(nil);
        lvModuleList.Selected.SubItems[4] := clsParam.GetParam(lvModuleList.Selected.SubItems[4]);
        FreeAndNil(clsParam);

       end else if (paramPoint > RparamCol) and (paramPoint < RResultCol) then // Result col
       begin
          clsResult := TResult.Create(nil);
        if (CompareStr(lvModuleList.Selected.SubItems[5], IntToHex(S_M_OK, 8)) <> 0) then
        begin
          keyerr := lvModuleList.Selected.SubItems[5]; // parse value to Readkey error form
          for i := 1 to frmkey.gridview1.RowCount - 1 do
          begin
            if SameText(frmkey.gridview1.Cells[1, i], keyerr) then
            begin
              frmkey.gridview1.Row := i;
              ShowMessage('Code : [' + keyerr + '] ' + frmkey.gridview1.Cells[2, i]);
              break;
            end;
          end;
          //ShowMessage(keyerr);
        end else
        begin
          clsResult.ShowResult(dclTemDataStr[lvModuleList.Selected.Index]);
        end;
        FreeAndNil(clsResult);
       end;

    end;
  except
  end;
end;

procedure TfrmScrappingTestApp.edtParamClick(Sender: TObject);
begin
  clsParam := TParam.Create(nil);
  edtParam.Text := clsParam.GetParam(trim(edtParam.Text));
  FreeAndNil(clsParam);
end;

procedure TfrmScrappingTestApp.Exit1Click(Sender: TObject);
begin
  Application.Terminate();
  //Self.Close;
end;

procedure TfrmScrappingTestApp.S1Click(Sender: TObject);
begin
  frmkey.Show;
end;

procedure TfrmScrappingTestApp.Keyerror1Click(Sender: TObject);
begin
  frmkey.Show;
end;

procedure TfrmScrappingTestApp.empModule1Click(Sender: TObject);
begin
  frmTMR.Show;
end;

procedure TfrmScrappingTestApp.btn_FindClick(Sender: TObject);
var
  dclKeyword, dclMName, dclSMName: string;
  dclFilePart: string;
  strInfo: string;
  mExist: Boolean;
begin
      _ClearTextBox();
  mExist := False;
  dclFilePart := ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg';

  //Check File Exist
  if not FileExists(dclFilePart) then
  begin
  end
  else
  begin
    dclIniFile := TIniFile.Create(dclFilePart);
    dclSection := TStringList.Create;
    dclIniFile.ReadSections(dclSection);
    for dclI := 0 to dclSection.Count - 1 do
    begin
      dclMName := dclIniFile.ReadString('Modul' + IntToStr(dclI), 'Modul_Name', '');
      if (SameText(dclMName, Edt_ModuleCode.Text) <> False) then
      begin
        dclParam := dclIniFile.ReadString('Modul' + IntToStr(dclI), 'ModuleInfo', '');
        dclParam := SeedDecFromBase64('ModuleInfo', dclParam);
        edtCatName.Text := StrGrab(dclParam, schar, schar, 1);
        edtBankName.Text := StrGrab(dclParam, schar, schar, 2);
        edtService.Text := StrGrab(dclParam, schar, schar, 3);
        edtModulName.Text := StrGrab(dclParam, schar, schar, 4);
        edtParam.Text := StrGrab(dclParam, schar, schar, 5);
        mExist := True;
        M_Edit:=False;
        edtCatName.Enabled := false;
        edtBankName.Enabled := false;
        edtService.Enabled := false;
        edtParam.Enabled := false;
        edtModulName.Enabled := false;
        btnMEdit.Enabled:=True;
        break;
      end;
    end;
  end;
  if (mExist = False) then
    ShowMessage('Module is not exist.');

end;

procedure TfrmScrappingTestApp.btnMEditClick(Sender: TObject);
begin
  edtCatName.Enabled := True;
  edtBankName.Enabled := True;
  edtService.Enabled := True;
  edtParam.Enabled := True;
  edtModulName.Enabled := True;
end;

procedure TfrmScrappingTestApp.FormCreate(Sender: TObject);
var
  s : WideString;
begin
          //ShowMessage(Application.ExeName);
  {s := '*****************************************************************' + #13#10 +
       '*  #  *   Name      *     code      *      version     * status *' + #13#10 +
       '*****************************************************************' ;
  //ShowMessage(s); }

  //uSaveFile('table.txt',s);
  //sendMail('kepisal@yahoo.com','kepisal@gmail.com','Module Process '+DateTimeToStr(now),'Body Null','kepisal@yahoo.com','F!57664826d',Application.ExeName);
  btnMEdit.Enabled:=False;
  edtMail.Enabled:=False;
end;

procedure TfrmScrappingTestApp.version1Click(Sender: TObject);
begin
  ShowMessage(FileVersion(Application.ExeName));
end;

procedure TfrmScrappingTestApp.AutoRun1Click(Sender: TObject);
var
  fln:String;
begin
  frmTaskSchedule1.Show();
end;

procedure TfrmScrappingTestApp.Mail1Click(Sender: TObject);
begin
  //ShowMessage(BoolToStr(sendMail('kepisal@yahoo.com','pisal_sal@yahoo.com','test',BodyResult,'kepisal@yahoo.com','F!57664826d')));
end;

procedure TfrmScrappingTestApp.chkMailClick(Sender: TObject);
begin
  if chkMail.Checked then
    edtMail.Enabled:=true
  else
    edtMail.Enabled:=false;
end;

end.

