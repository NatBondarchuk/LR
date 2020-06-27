program SlideShow;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, FrmSlideShow, unit1, About
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFrmSlide, FrmSlide);
  Application.CreateForm(TFrmOption, FrmOption);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

