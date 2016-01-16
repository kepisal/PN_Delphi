unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uMethod, uTester, seed,ufrmSignup;

type
  Tfrmlogin = class(TForm)
    Welcom: TGroupBox;
    Label1: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblsignup: TLabel;
    btnlogin: TButton;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnloginClick(Sender: TObject);
    procedure lblsignupClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmlogin: Tfrmlogin;
  myFile: TextFile;
  text1, result, uName, pWord: string;
  isName, ispwd: Boolean;
  i, j, arr_size: Integer;
  arr_un: array of string;
  arr_pwd: array of string;

implementation

{$R *.dfm}

procedure Tfrmlogin.btnloginClick(Sender: TObject);
var
  temp,fullFileName: string;
begin
  isName := False;
  ispwd := False;
  i := 0;
  j := 0;

  fullFileName:=Application.ExeName;
  fullFileName:=ExtractFilePath  (fullFileName)+'data.txt';
  //assign Test.txt file to myFile
  AssignFile(myFile, fullFileName);
  //if Test.txt file is existed then
  if FileExists(fullFileName) then
  begin

    arr_size := 0;
    
      //openfile to define the array size
    Reset(myFile);

    while not Eof(myFile) do
    begin
      readln(myFile, result);
      inc(arr_size);
    end;
      //close file
    CloseFile(myFile);
      //define the size of our dynamic array arr_un, arr_pwd
    SetLength(arr_un, arr_size);
    SetLength(arr_pwd, arr_size);
      //open to get data from file
    Reset(myFile);
    while not Eof(myFile) do
    begin
        //read data and string crop to get user name, password to put in array
      Readln(myFile, text1);
        arr_un[i]:=SeedDecFromBase64(keyEnc,StrGrab(text1,'{userName="','"'));
        arr_pwd[j]:=SeedDecFromBase64(keyEnc,StrGrab(text1,'password="','"'));

        // To make index of array to be increase
        Inc(i);
        Inc(j);
    end;

    CloseFile(myFile);

    //assign the value from the text box to uName and pWord
    uName := edtUsername.Text;
    pWord := edtPassword.Text;
    //if text box is empty then
    if (uName = '') or (pWord = '') then
      ShowMessage('User name and password are required !')
    else
    // if not then
    begin
        // search if the user name is match
      for i := Low(arr_un) to High(arr_un) do
      begin
        if arr_un[i] = uName then
        begin
              // if match the isName will store true
          isName := True;
        end;
      end;
        //search if the password is match
      for j := Low(arr_pwd) to High(arr_pwd) do
      begin
        if arr_pwd[j] = pWord then
        begin
              // if match the ispwd will store true
          ispwd := True;
        end;
      end;
      // if isName and ispwd is true then
      if (isName) and (ispwd) then
        // show message
      begin
        Self.Hide;
        frmScrappingTestApp.Show();

      end
      else
        // if not then show message
        ShowMessage('User name or password is incorrect !');
    end;

  end
  //if the Test.txt file is not existed then
  else
    // show message to user
    ShowMessage('Login failed !');

end;

procedure Tfrmlogin.lblsignupClick(Sender: TObject);
begin
  frmsignup.Show;
end;

procedure Tfrmlogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action :=caFree;
  Application.Terminate();
end;

end.

