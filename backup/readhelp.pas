unit readHelp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TFrmReadHelp }

  TFrmReadHelp = class(TForm)
    btnOK: TBitBtn;
    Label1: TLabel;
    procedure btnOKClick(Sender: TObject);
  private

  public

  end;

var
  FrmReadHelp: TFrmReadHelp;

implementation

{$R *.lfm}

{ TFrmReadHelp }

procedure TFrmReadHelp.btnOKClick(Sender: TObject);
begin
   FrmReadHelp.Close;
end;

end.

