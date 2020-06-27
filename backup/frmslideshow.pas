unit FrmSlideShow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  Buttons, Option, About, readHelp, StdCtrls, ExtDlgs;

type

  { TFrmSlide }

  TFrmSlide = class(TForm)
    BtnNext: TSpeedButton;
    BtnPause: TSpeedButton;
    BtnPrev: TSpeedButton;
    imgTheme: TImage;
    Label1: TLabel;
    lblSlide: TLabel;
    lblCount: TLabel;
    lblPath: TLabel;
    MenuHelp: TMenuItem;
    MenuReadHelp: TMenuItem;
    MenuAbout: TMenuItem;
    MenuOption: TMenuItem;
    SelDir: TSelectDirectoryDialog;
    OpenPic: TOpenPictureDialog;
    Image1: TImage;
    MenuSlide: TMainMenu;
    MenuDark: TMenuItem;
    MenuChild: TMenuItem;
    MenuEng: TMenuItem;
    MenuCatalog: TMenuItem;
    MenuKCosm: TMenuItem;
    MenuKFlowers: TMenuItem;
    MenuKOther: TMenuItem;
    MenuRus: TMenuItem;
    MenuLang: TMenuItem;
    MenuLight: TMenuItem;
    MenuTheme: TMenuItem;
    MenuMod: TMenuItem;
    MenuBase: TMenuItem;
    MenuFull: TMenuItem;
    PanImg: TPanel;
    PanTheme: TPanel;
    TimePic: TTimer;
    procedure ChooseText();
    procedure Label1Click(Sender: TObject);
    procedure MenuOptionClick(Sender: TObject);
    procedure Help(Sender: TObject);
    procedure Pan(Sender: TObject);
    procedure StartTime(Sender: TObject);
    procedure Theme(Sender: TObject);
    procedure WhatWhom(Sender: TObject);
    procedure ChangeSlide(Sender: TObject);
    procedure Pause(Sender: TObject);
    procedure ChangeLang(Sender: TObject);
    procedure ScreenMod(Sender: TObject);
    procedure ChooseCatalog(Sender: TObject);
    procedure ChooseList(dirPath : String);
  private

  public

  end;

var
  FrmSlide: TFrmSlide;
  numPic, numText : integer;
  stp : boolean;
  pathFile, dirPath, repName : string;
  DirList, SlideText: TStrings;

implementation

{$R *.lfm}

{ TFrmSlide }
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.WhatWhom(Sender: TObject);
begin
  stp := true;
  ScreenMod(MenuBase);
  Theme(MenuDark);
  pathFile := 'C:\Users\guurx\Documents\GitHub\LR\1.txt.txt';
  ChooseText();
  ChooseCatalog(MenuKCosm);
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
function ExtractFilePathLast(aPath: string): string;
begin
  Result := Copy(aPath, aPath.LastIndexOf(DirectorySeparator) + 2)
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.ChooseCatalog(Sender: TObject);
begin
  if (Sender as TMenuItem).Name = 'MenuKCosm' then
     dirPath := 'C:\Users\guurx\Documents\GitHub\LR\Theme\Cosmos';
  if (Sender as TMenuItem).Name = 'MenuKFlowers' then
     dirPath := 'C:\Users\guurx\Documents\GitHub\LR\Theme\Flowers';
  if (Sender as TMenuItem).Name = 'MenuKOther' then begin
     if SelDir.Execute then begin
        dirPath := SelDir.FileName;
        repName := ExtractFilePathLast(SelDir.FileName);
        lblPath.Caption := dirPath;
     end;
  end;
  ChooseList(dirPath);
  numPic := -1;
  numText := -1;
  ChangeSlide(BtnNext);
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.StartTime(Sender: TObject);
begin
   ChangeSlide(BtnNext);
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.ChooseList(dirPath : String);
var SR : TSearchRec;
begin
   DirList := TStringList.Create;
   if FindFirst(dirPath + '/' + '*.*', faArchive, SR) = 0 then
   begin
      repeat
         DirList.Add(StringReplace(dirPath + '\' + SR.Name, '/', '\',
                                           [rfReplaceAll, rfIgnoreCase]));
      until FindNext(SR) <> 0;
      FindClose(SR);
   end;
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.Pause(Sender: TObject);
begin
   if stp = false then begin
      TimePic.Enabled := false;
      stp := true;
      btnPause.Caption := 'Пуск';
   end
   else begin
      TimePic.Enabled := true;
      stp := false;
      btnPause.Caption := 'Пауза';
   end;
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.Pan(Sender: TObject);
var nowX, X : integer;
begin
   nowX := Mouse.CursorPos.x;
   X := trunc(PanImg.Width/3);
   if (nowX > 2*(X)) then
      ChangeSlide(BtnNext);
   if (nowX < X) then
      ChangeSlide(BtnPrev);
   if ((nowX > X) and
      (nowX < 2*(X))) then
      Pause(BtnPause);
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
function sortList(list : TStrings; key : string): TStrings;
var s : string;
    i,j,n : integer;
    M: array[0..100] of integer;
    f: boolean;
begin
  case key of
    'alf': begin
      for i := 0 to list.Count - 1 do
        for j := 0 to i - 1 do begin
          if list[i] < list[j] then begin
            s := list[i];
            list[i] := list[j];
            list[j] := s;
          end;
        end;
    end;
    'revAlf': begin
      for i := 0 to list.Count - 1 do
        for j := 0 to i - 1 do begin
          if list[i] > list[j] then begin
            s := list[i];
            list[i] := list[j];
            list[j] := s;
          end;
        end;
    end;
    'rand': begin
      n := list.Count;
      for i := 0 to n - 1 do begin
        m[i] := random(n);
        repeat
          f := true;
          for j := 0 to i - 1 do
            if m[i] = m[j] then begin
              f := false;
              m[i] := random(n)
            end
        until f = true;
      end;
      for j := 0 to n - 1 do begin
        s := list[j];
        list[j] := list[m[j]];
        list[m[j]] := s;
      end;
    end;
  end;
  sortList := list;
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.ChooseText();
var data : string;
    readFile : TextFile;
begin
  assignFile(readFile, pathFile);
  SlideText := TStringList.Create;
  if FileExists(pathFile) then
    begin
      Reset(readFile);
      while not Eof(readFile) do
      begin
        readln(readFile, data);
        SlideText.Add(data);
      end;
      CloseFile(readFile);
    end;
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.MenuOptionClick(Sender: TObject);
begin
  FrmOption.ShowModal;
  TimePic.Interval := trunc(StrToFloat(FrmOption.SlideTime.Text)*1000);

  case FrmOption.OrderSlide.Text of
    'В алфавитном порядке (А-Я)': DirList := sortList(DirList,'alf');
    'В обратном алфавитном порядке (Я-А)': DirList := sortList(DirList,'revAlf');
    'В случайном порядке': DirList := sortList(DirList,'rand');
  end;
  numPic := -1;

  pathFile := FrmOption.editPath.Text;
  ChooseText();
  case FrmOption.OrderText.Text of
    'В алфавитном порядке (А-Я)': SlideText := sortList(SlideText,'alf');
    'В обратном алфавитном порядке (Я-А)': SlideText := sortList(SlideText,'revAlf');
    'В случайном порядке': SlideText := sortList(SlideText,'rand');
    '<По умолчанию>': ChooseText();
  end;
  numText := -1;
  lblSlide.Font.Color := FrmOption.btnColor.Color;
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.Help(Sender: TObject);
begin
  if (Sender as TMenuItem).Name = 'MenuReadHelp' then FrmReadHelp.ShowModal;
  if (Sender as TMenuItem).Name = 'MenuAbout' then FrmAbout.ShowModal;
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.Label1Click(Sender: TObject);
begin
   ScreenMod(MenuBase);
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.ChangeSlide(Sender: TObject);
var step : integer;
begin
   case (Sender as TSpeedButton).Name of
     'BtnNext': step := 1;
     'BtnPrev': step := -1;
   end;
   numPic := numPic + step;
   if (dirPath <> '') then begin
      if ((numPic > DirList.Count - 1) and (step = 1)) then numPic := 0;
      if ((numPic < 0) and (step = -1)) then numPic := DirList.Count - 1;
      Image1.Picture.LoadFromFile(dirlist[numPic]);
      lblPath.Caption := dirlist[numPic];
      lblCount.Caption := IntToStr(numPic + 1) + '  /  ' + IntToStr(DirList.Count);
   end
   else lblPath.Caption := 'Directory not selected';
   numText := numText + step;
   if (pathFile <> '') then begin
     if ((numText > SlideText.Count - 1) and (step = 1)) then numText := 0;
     if ((numText < 0) and (step = -1)) then numText := SlideText.Count - 1;
      lblSlide.Caption := SlideText[numText];
   end
   else lblSlide.Caption := 'Не выбран файл';
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.Theme(Sender: TObject);
var num, i : integer;
    colBack : array [1..3] of TColor = ($00121410, $0086BF00,clWhite);
    colBorder : array [1..3] of TColor = ($0000B8FD, $0000B8FD, $0052A0CF);
    colFont : array [1..3] of TColor = (clWhite, $00DAFEF7, $00DCC945);
    colBut : array [1..3] of TColor = ($00003042, $0086BF00, $00DFE6EA);
    nameFont : array [1..3] of string = ('Comic Sans MS', 'Snap ITC', 'Tempus Sans ITC');
    name_ar_btn : array [1..3] of string = ('Next', 'Prev', 'Pause');
    name_ar_lbl : array [1..3] of string = ('Path', 'Count', 'Slide');
begin
  case (Sender as TMenuItem).Name of
    'MenuDark': num := 1;
    'MenuLight': num := 3;
    'MenuChild': num := 2;
  end;
  imgTheme.Picture.LoadFromFile(IntToStr(num)+'.jpg');
  PanImg.Color := colBack[num];
  PanImg.BevelColor := colBorder[num];
  PanTheme.BevelColor := colBorder[num];
  for i := 1 to length(name_ar_btn) do begin
    (FindComponent('Btn' + name_ar_btn[i]) as TSpeedButton).Color := colBut[num];
    (FindComponent('Btn' + name_ar_btn[i]) as TSpeedButton).Font.Name := nameFont[num];
    (FindComponent('Btn' + name_ar_btn[i]) as TSpeedButton).Font.Color := colFont[num];
  end;
  for i := 1 to length(name_ar_lbl) do begin
    (FindComponent('lbl' + name_ar_lbl[i]) as TLabel).Font.Color := colFont[num];
    (FindComponent('lbl' + name_ar_lbl[i]) as TLabel).Font.Name := nameFont[num];
  end;
end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.ScreenMod(Sender: TObject);
var butTop, butCent,i : integer;
    nameMenu : array [1..6] of string = ('Mod', 'Theme', 'Lang', 'Catalog', 'Option', 'Help');
begin

  if (Sender as TMenuItem).Name = 'MenuFull' then begin
      FrmSlide.WindowState := wsMaximized;
      FrmSlide.BorderStyle := bsNone;
      FrmSlide.Width := Screen.Width;
      FrmSlide.height := Screen.Height;
      for i := 1 to length(nameMenu) do
        (FindComponent('Menu' + nameMenu[i]) as TMenuItem).Visible := false;
      PanTheme.Visible := false;
      Label1.Visible := true;
  end;

  if (Sender as TMenuItem).Name = 'MenuBase' then begin
     FrmSlide.WindowState := wsNormal;
     FrmSlide.BorderStyle := bsSizeable;
     FrmSlide.Width := 1300;
     FrmSlide.height := 840;
     Label1.Visible := false;
     PanTheme.Visible := true;
     for i := 1 to length(nameMenu) do
        (FindComponent('Menu' + nameMenu[i]) as TMenuItem).Visible := true;
  end;

  butTop := trunc(PanTheme.Height/2-BtnNext.Height/2);
  BtnNext.Top := butTop;
  BtnPrev.Top := butTop;
  BtnPause.Top := butTop;
  butCent := trunc(PanTheme.Width/2);
  BtnPause.Left := butCent - trunc(BtnPause.Width/2);
  BtnPrev.Left := butCent - BtnPrev.Width - trunc(BtnPause.Width/2) - 50;
  BtnNext.Left := butCent + trunc(BtnPause.Width/2) + 50;
  lblCount.Left := trunc(PanImg.Width/2 - lblCount.Width/2);

end;
//____________________________________________________________________________//
//____________________________________________________________________________//
procedure TFrmSlide.ChangeLang(Sender: TObject);
var i : integer;
    it_name : array[1..18] of string = ('Mod', 'Base', 'Full', 'Theme', 'Dark',
                                        'Light', 'Child', 'Lang', 'Rus', 'Eng',
                                        'Catalog', 'KCosm', 'KFlowers', 'KOther',
                                        'Option', 'Help', 'ReadHelp','About');
    eng : array[1..18] of string = ('Mode', 'Base', 'Fullscreen', 'Theme', 'Dark',
                                    'Light', 'Child', 'Language', 'Русский', 'English',
                                    'Catalog', 'Cosmos', 'Flowers', 'Other...',
                                    'Options', 'Help', 'Read help','About program');
    rus : array[1..18] of string = ('Режим', 'Обычный', 'Полноэкранный', 'Тема',
                                    'Тёмная', 'Светлая', 'Детская', 'Русский/English',
                                    'Русский', 'English', 'Каталог', 'Космос',
                                    'Цветы', 'Другой...','Настройки','Справка',
                                    'Читать справку', 'О программе');
begin

  if MenuRus.Checked = true then
    for i := 1 to length(it_name) do
      (FindComponent('Menu' + it_name[i]) as TMenuItem).Caption := rus[i];

  if MenuEng.Checked = true then
    for i := 1 to length(it_name) do
      (FindComponent('Menu' + it_name[i]) as TMenuItem).Caption := eng[i];

end;
end.

