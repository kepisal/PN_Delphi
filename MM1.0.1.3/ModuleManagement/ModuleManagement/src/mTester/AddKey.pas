unit AddKey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Seed;

type
  TfrmAddkey = class(TForm)
    GroupBox1: TGroupBox;
    edtKeyCode: TEdit;
    Label1: TLabel;
    mmoKeyDefin: TMemo;
    Label2: TLabel;
    btnAddKEy: TButton;
    procedure btnAddKEyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddkey: TfrmAddkey;
   
  dataKey:String;
implementation

uses uReadky;

{$R *.dfm}
 function EncryptString(source: string): Boolean;
var
  textString,fullFileName: string;
  F: TextFile;
begin
  fullFileName:=Application.ExeName;
  fullFileName:=ExtractFilePath  (fullFileName)+'key.bin';
  AssignFile(F, fullFileName);
  ReWrite(F);
  textString := SeedEncToBase64(fullFileName, source);
  Write(F, textString);
  //Write(F, source);
  CloseFile(F);
  Result := False;
end;
procedure TfrmAddkey.btnAddKEyClick(Sender: TObject);
var
  lastRow:Integer;
  Code:String;
  i:Integer;
  notExit:Boolean;
begin
  notExit:=false;
  lastRow:=frmkey.gridview1.RowCount;
  if (edtKeyCode.Text = '') or (mmoKeyDefin.Text = '') or (Length(edtKeyCode.Text)>10) then
    ShowMessage('Invalid data!!!')
  else
  begin
    for i := 1 to frmkey.gridview1.RowCount-1 do
      if SameText(frmkey.gridview1.Cells[1, i],edtKeyCode.Text) then
      begin
      ShowMessage('Duplicated Data');
      notExit:=true;
      break;
      end;
    end;

    if notExit = False then
      begin
      Code:=Copy(edtKeyCode.text,1,10);
      frmkey.gridview1.RowCount:=frmkey.gridview1.RowCount+1;
      frmkey.gridview1.Cells[0,lastRow]:=IntToStr(lastRow);
      frmkey.gridview1.Cells[1,lastRow]:=Code;
      frmkey.gridview1.Cells[2,lastRow]:=mmoKeyDefin.Text;

      Insert(',[('+edtKeyCode.Text+')]={[_'+mmoKeyDefin.Text+'_]}',dataKey,Pos('}}', dataKey)+1);

      EncryptString(dataKey);
      frmAddkey.edtKeyCode.Text:='';
      frmAddkey.mmoKeyDefin.Lines.Clear;
      frmAddkey.Close;
    end;
  end;


end.
