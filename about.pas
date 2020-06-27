unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls;

type

  { TFrmAbout }

  TFrmAbout = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private

  public

  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.lfm}

{ TFrmAbout }

procedure TFrmAbout.BitBtn1Click(Sender: TObject);
begin
   FrmAbout.Close;
end;

end.

