unit uReadky;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, uMethod, Grids, Seed, Menus,StrUtils,AddKey;

type
  Tfrmkey = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    mmdefinition: TMemo;
    Label1: TLabel;
    edtKey: TEdit;
    gridview1: TStringGrid;
    btnAddKEy: TButton;
    procedure FormCreate(Sender: TObject);
    procedure gridview1DblClick(Sender: TObject);
    procedure edtKeyKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddKEyClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  FileName = 'key.bin';
var
  frmkey: Tfrmkey;

implementation

{$R *.dfm}

function EncryptString(source: string): Boolean;
var
  textString: string;
  F: TextFile;
begin
  AssignFile(F, FileName);
  ReWrite(F);
  textString := SeedEncToBase64(FileName, source);
  Write(F, textString);
  //Write(F, source);
  CloseFile(F);
  Result := False;
end;

function DecryptString(): string;
var
  text, temp,fullFileName: string;
  F: TextFile;
begin
  fullFileName:=Application.ExeName;
  fullFileName:=ExtractFilePath(fullFileName)+FileName;
  //ShowMessage(fullFileName);
  AssignFile(F, fullFileName);
  // Reopen the file for reading
  Reset(F);

  // Display the file contents
  while not Eof(F) do
  begin
    ReadLn(F, text);
    temp := temp + text;
  end;
  // Close the file for the last time
  CloseFile(F);
  Result := SeedDecFromBase64(FileName, temp);
end;

//-----------------
function ExtractBetween(const Value, A, B: string): string;
var
  aPos, bPos: Integer;
begin
  result := '';
  aPos := Pos(A, Value);
  ShowMessage(IntToStr(aPos));
  if aPos > 0 then begin
    aPos := aPos + Length(A);
    bPos := PosEx(B, Value, aPos);
    if bPos > 0 then begin
      result := Copy(Value, aPos, bPos - aPos);
    end;
  end;



end;
//-----------------

procedure Tfrmkey.FormCreate(Sender: TObject);
var
  dataFile: TextFile;
  text,text1, temp, code, defi: string;
  i: Integer;
  j: Integer;
  NewColumn: TListColumn;
  ListItem: TListItem;
begin
  i := 1;
  j:=1;

  {AssignFile(dataFile,'Text.txt');
  Reset(dataFile);
  while not Eof(dataFile) do
  begin
    ReadLn(dataFile, text);
    temp := temp + text;
  end;

  ShowMessage(BoolToStr(EncryptString(text)));

  CloseFile(dataFile);}

  gridview1.ColCount := 3;

  gridview1.ColWidths[0] := 50;
  gridview1.ColWidths[1] := 270;
  gridview1.ColWidths[2] := 0;

  gridview1.Cells[0, 0] := 'No';
  gridview1.Cells[1, 0] := 'Key Code';

  text := DecryptString();
  text1:=DecryptString();

//  Insert(',[(A1005)]={[_ABCDEFG5_]}',text,Pos('}}', text)+1);

  while True do
  begin
    code := StrGrab(text, '[(', ')]', j);
    defi := StrGrab(text, '{[_', '_]}', j);

    if (code <> '') then
    begin
      gridview1.RowCount := i+1;
      gridview1.Cells[0, i] := IntToStr(i);
      gridview1.Cells[1, i] := code;
      gridview1.Cells[2, i] := defi;
    end
    else
    begin
       break;
    end;
    Inc(i);
    Inc(j);
  end;
  //ShowMessage(BoolToStr(EncryptString(text)));
 //------------------------------------------
end;



procedure Tfrmkey.gridview1DblClick(Sender: TObject);
var
  col, row: Integer;
begin
  col := gridview1.Col;
  row := gridview1.Row;
  mmdefinition.Lines.Clear();
  mmdefinition.Lines.Add('Key Definition');
  if ((col < 2)) and (row = 0) then
     // Do nothing                 
  else
   mmdefinition.Lines.Clear();
      mmdefinition.Lines.Add('Error Definition');
      mmdefinition.Lines.Add('---------------------------');
      mmdefinition.Lines.Add('EN : ' + gridview1.Cells[2, row]);
      mmdefinition.Lines.Add('KR : ' + gridview1.Cells[2, row]);
      mmdefinition.Lines.Add('KH : ' + gridview1.Cells[2, row]);
      mmdefinition.Lines.Add('---------------------------');

end;

procedure Tfrmkey.edtKeyKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Integer;
begin
  if (edtKey.Text = '') or (Length(edtKey.Text) > 8) then
    mmdefinition.Lines.Clear()
  else
    begin

  for i := 1 to gridview1.RowCount - 1 do
    if SameText(gridview1.Cells[1, i], edtKey.Text) then
    begin
      gridview1.Row := i;
      mmdefinition.Lines.Clear();
      mmdefinition.Lines.Add('Error Definition');
      mmdefinition.Lines.Add('---------------------------');
      mmdefinition.Lines.Add('EN : ' + gridview1.Cells[2, i]);
      mmdefinition.Lines.Add('KR : ' + gridview1.Cells[2, i]);
      mmdefinition.Lines.Add('KH : ' + gridview1.Cells[2, i]);
      mmdefinition.Lines.Add('---------------------------');
      break;
    end
    else
    begin
      mmdefinition.Lines.Clear();
    end;

  end;
end;
procedure Tfrmkey.btnAddKEyClick(Sender: TObject);
begin
    frmAddkey.Show;
end;

end.
