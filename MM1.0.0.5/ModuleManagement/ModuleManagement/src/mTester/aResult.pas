unit aResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TResult = class(TForm)
    mResult: TMemo;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowResult(const ResultStr: String);
  end;

var
  Result: TResult;

implementation

{$R *.dfm}

procedure TResult.ShowResult(const ResultStr: String);
begin
    ShowMessage('Result'+Application.ExeName);
  mResult.Lines.Clear;
  mResult.Lines.Add(ResultStr);
  mResult.SelStart := 0;
  mResult.SelLength := 0;
  mResult.Perform(EM_SCROLLCARET, 0, 0);

  if Self.ShowModal = mrOk then Self.Close;
end;

procedure TResult.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TResult.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

end.
