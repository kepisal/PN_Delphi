unit mParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Seed, uMethod;

type
  TParam = class(TForm)
    edtParam1: TEdit;
    edtParam2: TEdit;
    edtParam3: TEdit;
    edtParam4: TEdit;
    edtParam5: TEdit;
    edtParam6: TEdit;
    edtParam7: TEdit;
    edtParam8: TEdit;
    edtParam9: TEdit;
    edtParam10: TEdit;
    edtParam11: TEdit;
    edtParam12: TEdit;
    edtParam13: TEdit;
    edtParam14: TEdit;
    edtParam15: TEdit;
    edtParam16: TEdit;
    edtParam17: TEdit;
    edtParam18: TEdit;
    edtParam19: TEdit;
    edtParam20: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    GroupBox1: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetParam(const mParam: String): String;
  end;

var
  Param: TParam;

implementation

{$R *.dfm}

function TParam.GetParam(const mParam: String): String;
var
  aParam: String;
begin
  if mParam <> '' then begin
    aParam := SeedDecFromBase64('mParam', mParam);
    edtParam1.Text := StrGrab(aParam, 'Param1=', 'Param');
    edtParam2.Text := StrGrab(aParam, 'Param2=', 'Param');
    edtParam3.Text := StrGrab(aParam, 'Param3=', 'Param');
    edtParam4.Text := StrGrab(aParam, 'Param4=', 'Param');
    edtParam5.Text := StrGrab(aParam, 'Param5=', 'Param');
    edtParam6.Text := StrGrab(aParam, 'Param6=', 'Param');
    edtParam7.Text := StrGrab(aParam, 'Param7=', 'Param');
    edtParam8.Text := StrGrab(aParam, 'Param8=', 'Param');
    edtParam9.Text := StrGrab(aParam, 'Param9=', 'Param');
    edtParam10.Text := StrGrab(aParam, 'Param10=', 'Param');
    edtParam11.Text := StrGrab(aParam, 'Param11=', 'Param');
    edtParam12.Text := StrGrab(aParam, 'Param12=', 'Param');
    edtParam13.Text := StrGrab(aParam, 'Param13=', 'Param');
    edtParam14.Text := StrGrab(aParam, 'Param14=', 'Param');
    edtParam15.Text := StrGrab(aParam, 'Param15=', 'Param');
    edtParam16.Text := StrGrab(aParam, 'Param16=', 'Param');
    edtParam17.Text := StrGrab(aParam, 'Param17=', 'Param');
    edtParam18.Text := StrGrab(aParam, 'Param18=', 'Param');
    edtParam19.Text := StrGrab(aParam, 'Param19=', 'Param');
    edtParam20.Text := StrGrab(aParam, 'Param20=', 'Param');
  end;

  if Self.ShowModal = mrOk then
  begin
    aParam := 'Param1=' + trim(edtParam1.Text)
            + 'Param2=' + trim(edtParam2.Text)
            + 'Param3=' + trim(edtParam3.Text)
            + 'Param4=' + trim(edtParam4.Text)
            + 'Param5=' + trim(edtParam5.Text)
            + 'Param6=' + trim(edtParam6.Text)
            + 'Param7=' + trim(edtParam7.Text)
            + 'Param8=' + trim(edtParam8.Text)
            + 'Param9=' + trim(edtParam9.Text)
            + 'Param10=' + trim(edtParam10.Text)
            + 'Param11=' + trim(edtParam11.Text)
            + 'Param12=' + trim(edtParam12.Text)
            + 'Param13=' + trim(edtParam13.Text)
            + 'Param14=' + trim(edtParam14.Text)
            + 'Param15=' + trim(edtParam15.Text)
            + 'Param16=' + trim(edtParam16.Text)
            + 'Param17=' + trim(edtParam17.Text)
            + 'Param18=' + trim(edtParam18.Text)
            + 'Param19=' + trim(edtParam19.Text)
            + 'Param20=' + trim(edtParam20.Text)
            + 'Param';
    Result := SeedEncToBase64('mParam', aParam);
  end else
    Result := mParam;
end;

procedure TParam.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TParam.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
