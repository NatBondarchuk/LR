program SlideShow;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, FrmSlideShow, Option, About, readHelp
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFrmSlide, FrmSlide);
  Application.CreateForm(TFrmOption, FrmOption);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.CreateForm(TFrmReadHelp, FrmReadHelp);
  Application.Run;
end.

