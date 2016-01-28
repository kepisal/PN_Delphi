unit uMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmMsg = class(TForm)
    pnlMsg: TPanel;
    lblcount: TLabel;
    tmrCount: TTimer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMsg: TfrmMsg;
  i:integer;
implementation

{$R *.dfm}


end.
