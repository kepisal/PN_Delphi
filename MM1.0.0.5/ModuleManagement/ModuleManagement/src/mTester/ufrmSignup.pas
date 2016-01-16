unit ufrmSignup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uMethod,Seed;

type
  Tfrmsignup = class(TForm)
    grp1: TGroupBox;
    btnSignUp: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtUserName: TEdit;
    edtPassword: TEdit;
    edtCnPssword: TEdit;
    procedure btnSignUpClick(Sender: TObject);
    procedure edtUserNameChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  keyEnc = 'Enc';
var
  frmsignup: Tfrmsignup;

implementation

{$R *.dfm}

procedure Tfrmsignup.btnSignUpClick(Sender: TObject);
var
  myFile:TextFile; result,strErr,temp,edt1,edt2,fullFileName:String;
  index:Integer;
begin
  index:=0;
  strErr:='';
   result:='';
   fullFileName:=Application.ExeName;
  fullFileName:=ExtractFilePath  (fullFileName)+'data.txt';
   // If the Text Boxes are empty then show message
   if (edtUserName.Text='') or (edtCnPssword.Text='') or (edtPassword.Text='') then
    begin
      strErr:='The user name, password and' +#13#10+
               'confirm password are required !' ;
      ShowMessage(strErr);
    end
   // If not then
   else
      // If the Text Boxes Password and Confirm Password is not match then
      if edtPassword.Text<>edtCnPssword.Text then
        begin
          //show message
          strErr:='Your confirm Password is not correct !'+#13#10+
               'Please, Input again.' ;
          ShowMessage(strErr);
        end
      // If not then
      else
        begin
          //assign from the file name to myFile
          AssignFile(myFile, fullFileName);
          // If there is the exist file
          if FileExists(fullFileName) then
            begin
              //Open file to read only
              Reset(myFile);
              // Loop to read data from file Test.txt
              while not Eof(myFile) do
              begin
                // To read data as Text from file
                Readln(myFile,temp);
              end;
              // To find the lastest index in file(String Crop and convert the string into Integer)
              index:=StrToIntDef(StrGrab(temp,'[',']='),0);
              // to increase the index by one
              index:=index+1;
              //open file for append
              Append(myFile);
            end
          //If not then
          else
            //open file for write new
            Rewrite(myFile);
          // write data to file
          edt1:=SeedEncToBase64(keyEnc,edtUserName.Text);
          edt2:=SeedEncToBase64(keyEnc,edtPassword.Text);
          Writeln(myFile,'['+IntToStr(index)+']={userName="'+edt1+'",password="'+edt2+'"}');
          //close the file
          CloseFile(myFile);
          ShowMessage('Account creating is success.');
          // clear text boxes
          edtUserName.Text:='';
          edtPassword.Text:='';
          edtCnPssword.Text:='';
          Self.Close;
        end;
end;

procedure Tfrmsignup.edtUserNameChange(Sender: TObject);
begin
  btnSignUp.Enabled:=True;
end;

procedure Tfrmsignup.FormCreate(Sender: TObject);
begin
  btnSignUp.Enabled:=False;
end;

end.
