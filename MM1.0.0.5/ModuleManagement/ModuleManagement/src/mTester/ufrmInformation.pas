unit ufrmInformation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmInformation = class(TForm)
    lblissue: TLabel;
    mmoissue: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInformation: TfrmInformation;

implementation

{$R *.dfm}

end.
