unit uTMR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls,Dialogs,mParam,uTester,uMethod;

type
  TfrmTMR = class(TForm)
    grpTMR_info: TGroupBox;
    lbl1: TLabel;
    edtTMR_code: TEdit;
    lbl2: TLabel;
    edtTMR_param: TEdit;
    btnTMR_submit: TButton;
    btnBrowser: TButton;
    procedure edtTMR_paramDblClick(Sender: TObject);
    procedure btnTMR_submitClick(Sender: TObject);
    procedure btnBrowserClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTMR: TfrmTMR;
  clsParam:TParam;
  iTMR : Integer = 1;
implementation

{$R *.dfm}

procedure TfrmTMR.edtTMR_paramDblClick(Sender: TObject);
begin
  clsParam := TParam.Create(nil);
  edtTMR_param.Text := clsParam.GetParam(trim(edtTMR_param.Text));
  //FreeAndNil(clsParam);
end;

procedure TfrmTMR.btnTMR_submitClick(Sender: TObject);
begin
  if (edtTMR_code.Text ='') or (edtTMR_param.Text ='') then
  begin
    ShowMessage('Module Code and Input Param are required !');
  end
  else
    begin
      dclList:=frmScrappingTestApp.lvModuleList.Items.Add;

          with dclList.SubItems do begin
            Add('Test');
            Add('Module Test ['+IntToStr(iTMR)+']');
            Add('Test');
            Add(edtTMR_code.Text);
            Add(edtTMR_param.Text);
            Add('Test');
            Add('Temporary Testing');
          end;
          Inc(iTMR);
          Self.Close;
          edtTMR_code.Text:='';
          edtTMR_param.Text:='';
    end;
    SetLength(dclTemDataStr,frmScrappingTestApp.lvModuleList.Items.Count);
end;

procedure TfrmTMR.btnBrowserClick(Sender: TObject);
var
  openDialog : topendialog;    // Open dialog variable
  i : Integer;
  name:String;
begin
  // Create the open dialog object - assign to our open dialog variable
  openDialog := TOpenDialog.Create(self);

  // Set up the starting directory to be the current one
  openDialog.InitialDir := GetCurrentDir;

  openDialog.Filter :='Delphi Module|*.kha';

  // Display the open file dialog
  if openDialog.Execute then
  begin
    name:=extractfilename(openDialog.FileName);
    edtTMR_code.Text:=StrGrab(name,'','.kha');
  end;

  // Free up the dialog
  openDialog.Free;
end;

end.
