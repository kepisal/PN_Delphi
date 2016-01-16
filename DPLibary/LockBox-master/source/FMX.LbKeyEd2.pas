(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is TurboPower LockBox
 *
 * The Initial Developer of the Original Code is
 * TurboPower Software
 *
 * Portions created by the Initial Developer are Copyright (C) 1997-2002
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)
{*********************************************************}
{*                  LBKEYED2.PAS 2.07                    *}
{*     Copyright (c) 2002 TurboPower Software Co         *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I LockBox.inc}

unit FMX.LbKeyEd2;

interface

uses
  DesignIntf, DesignEditors, FMX.Forms, FMX.ListBox, FMX.Edit, FMX.Types, FMX.Controls.Presentation,
  FMX.StdCtrls, System.Classes, FMX.Controls;

type
  TfrmRSAKeys = class(TForm)
    btnClose: TButton;
    Label4: TLabel;
    edtModulus: TEdit;
    Label5: TLabel;
    edtPublicExponent: TEdit;
    Label6: TLabel;
    edtPrivateExponent: TEdit;
    Bevel1: TPanel;
    StatusBar1: TStatusBar;
    Label9: TLabel;
    cbxKeySize: TComboBox;
    Label1: TLabel;
    Label8: TLabel;
    edtIterations: TEdit;
    btnGenerate: TButton;
    btnClear: TButton;
    Label2: TLabel;
    procedure btnGenRSAKeysClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    FAbort : Boolean;
    procedure RSACallback(var Abort : Boolean);
  end;

type
  TLbRSAKeyEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

implementation

{$R *.fmx}

uses
  System.UITypes, System.SysUtils, LbRSA, LbAsym, LbCipher, LbUtils;

{ == TLbRSAKeyKeyEditor ==================================================== }
procedure TLbRSAKeyEditor.ExecuteVerb(Index : Integer);
begin
  if (Index <> 0) then
    Exit;

  with TfrmRSAKeys.Create(Application) do
    try
      ShowModal;
    finally
      Free;
    end;
end;
{ -------------------------------------------------------------------------- }
function TLbRSAKeyEditor.GetVerb(Index : Integer) : string;
begin
  case Index of
    0 : Result := 'Generate RSA Key Pair';
  else
    Result := '?';
  end;
end;
{ -------------------------------------------------------------------------- }
function TLbRSAKeyEditor.GetVerbCount : Integer;
begin
  Result := 1;
end;

{ == TfrmKeys ============================================================== }
procedure TfrmRSAKeys.btnGenRSAKeysClick(Sender: TObject);
var
  Pub : TLbRSAKey;
  Pri : TLbRSAKey;
begin
  FAbort := False;
  Cursor := crHourglass;
  btnClearClick(nil);
  Label2.Text := 'Generating key pair, this may take a while';
  Pub := TLbRSAKey.Create(TLbAsymKeySize(cbxKeySize.ItemIndex));
  Pri := TLbRSAKey.Create(TLbAsymKeySize(cbxKeySize.ItemIndex));
  try
    TRSA.GenerateRSAKeysEx(Pri, Pub, TLbAsymKeySize(cbxKeySize.ItemIndex),
      StrToIntDef(edtIterations.Text, 20), RSACallback);
    edtModulus.Text := Pri.ModulusAsString;
    edtPublicExponent.Text := Pub.ExponentAsString;
    edtPrivateExponent.Text := Pri.ExponentAsString;
  finally
    Pri.Free;
    Pub.Free;
    Cursor := crDefault;
    Label2.Text := '';
  end;
end;
{ -------------------------------------------------------------------------- }
procedure TfrmRSAKeys.RSACallback(var Abort : Boolean);
begin
  Abort := FAbort;
end;
{ -------------------------------------------------------------------------- }
procedure TfrmRSAKeys.FormCreate(Sender: TObject);
begin
  cbxKeySize.ItemIndex := Ord(aks128);
end;
{ -------------------------------------------------------------------------- }
procedure TfrmRSAKeys.btnCloseClick(Sender: TObject);
begin
  FAbort := True;
end;
{ -------------------------------------------------------------------------- }
procedure TfrmRSAKeys.btnClearClick(Sender: TObject);
begin
  edtModulus.Text := '';
  edtPublicExponent.Text := '';
  edtPrivateExponent.Text := '';
  Application.ProcessMessages;
end;

end.


