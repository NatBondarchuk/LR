unit Option;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ActnList, Buttons;

type

  { TFrmOption }

  TFrmOption = class(TForm)
    Button1: TButton;
    clrText: TColorDialog;
    editPath: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    lblTimer: TLabel;
    OpenFile: TOpenDialog;
    OrderSlide: TComboBox;
    OrderText: TComboBox;
    SlideTime: TEdit;
    btnColor: TSpeedButton;
    procedure Read(Sender: TObject);
    procedure ColorText(Sender: TObject);
  private

  public

  end;

var
  FrmOption: TFrmOption;

implementation

{$R *.lfm}

{ TFrmOption }

procedure TFrmOption.Read(Sender: TObject);
var str : string;
begin
  if OpenFile.Execute then begin
    str := OpenFile.FileName;
    editPath.Text := str;
  end;
end;
procedure TFrmOption.ColorText(Sender: TObject);
begin
  if clrText.Execute then begin
    btnColor.Color := clrText.Color;
  end;
end;
end.

