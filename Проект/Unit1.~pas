unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, ExtCtrls, ImgList, jpeg;

type

  TForm1 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    LabelPlayer: TLabel;
    LabelDice1: TLabel;
    LabelDice2: TLabel;
    LabelHome1: TLabel;
    LabelHome2: TLabel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    LabelPlayer1: TLabel;
    LabelPlayer2: TLabel;
    ImageFon: TImage;
    ButtonDrop: TButton;
    LabelTemp1: TLabel;
    ImageWhite: TImage;
    ImageBlack: TImage;
    ImageBlackSelected: TImage;
    ImageWhiteSelected: TImage;
    TimerMouse: TTimer;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    procedure FormCreate(Sender: TObject);
    procedure ReDraw(Sender: TObject);
    procedure FillLabel(Lab: TImage; n: integer);
    procedure Step(Sender: TObject);
    procedure Select(Sender: TObject; n: integer);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label21Click(Sender: TObject);
    procedure Label22Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure Label24Click(Sender: TObject);
    procedure LabelHome1Click(Sender: TObject);
    procedure LabelHome2Click(Sender: TObject);
    procedure CheckPossibility(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NewGame(Sender: TObject);
    procedure ButtonDropClick(Sender: TObject);
    procedure TimerMouseTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  map: array [1..24] of integer;
  color_map: array[1..24] of integer;

  player, dice1, dice2, selected_box: integer;

  take_from_start: integer; //0 - ещё не брал со старта, 1 - брал

  home1, home2: Boolean; //Возможность вывода из "Домика"
  home1_value, home2_value: integer; //Счёт Домиков!
  color_home1, color_home2: integer;

  redraw_map: array [1..24] of integer; //Массив ячеек на перерисовку

implementation

uses Math, Types;

{$R *.dfm}


//Начало игры!
procedure TForm1.NewGame(Sender: TObject);
var
  i: integer;
begin

  //Массив перерисовки
  for i := 1 to 24 do
    redraw_map[i] := 1;

  //Начальное положение
  for i := 1 to 24 do
    map[i] := 0;
  map[1] := 15;
  map[13] := -15;

  //Цвета полей
  for i := 1 to 24 do
    color_map[i] := 0; //0 - чисто; 1 - возможный ход; 2 - выделено!

  player := 1;
  dice1 := 0;
  dice2 := 0;

  home1 := False;
  home2 := False;

  color_home1 := 0;
  color_home2 := 0;

  take_from_start := 0;

  selected_box := 0;

  ReDraw(Sender);
  Step(Sender);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
end;

//Ход!
procedure TForm1.Step(Sender: TObject);
var
  i: integer;
begin

  ReDraw(Sender);

  //Проверка возможности хода
  if (dice1 + dice2 > 0) then
    CheckPossibility(Sender);


  if (home1 = False) then
  begin
    //Проверка того, что Игрок 1 в Домике
    home1 := True;
    for i := 1 to 18 do
      if map[i] > 0 then
        home1 := False;
  end;

  if (home2 = False) then
  begin
    //Проверка того, что Игрок 2 в Домике
    home2 := True;
    for i := 13 to 24 do
      if map[i] < 0 then
        home2 := False;
    for i := 1 to 6 do
      if map[i] < 0 then
        home2 := False;
  end;

  //Условие конца хода
  if (dice1 + dice2 = 0) then
    if ButtonDrop.Visible = False then
    begin
      ButtonDrop.Show;

      //Mouse.CursorPos := Point(Form1.Left + ButtonDrop.Left + 100, Form1.Top + ButtonDrop.Top + 100);

      if (player = 1) then
        player := 2
      else
        player := 1;
      take_from_start := 0;
    end;

  ReDraw(Sender);
end;

//Выбор поля!
procedure TForm1.Select(Sender: TObject; n: integer);
var
  i: integer;
  pos1, pos2: integer;
begin

  color_home1 := 0;
  color_home2 := 0;

  redraw_map[n] := 1;

  if selected_box > 0 then
    redraw_map[selected_box] := 1;





  //Проверка того, что нужно погасить клетку
  if color_map[n] = 2 then
    selected_box := 0
  else

  //Проверка того, что уже совершается ход!
  if color_map[n] = 1 then
  begin
    //Ход костью 1?
    if ((selected_box - 1 + dice1) mod 24 + 1) = n then
    begin
      if (player = 1) then
        ProgressBar1.Position := ProgressBar1.Position + dice1
      else
        ProgressBar2.Position := ProgressBar2.Position + dice1;
      dice1 := 0;
    end
    else  //Ход костью 2?
    begin
      if (player = 1) then
        ProgressBar1.Position := ProgressBar1.Position + dice2
      else
        ProgressBar2.Position := ProgressBar2.Position + dice2;
      dice2 := 0;
    end;

    //Ход
    if (map[selected_box] > 0) then //Ход в зависимости от игрока
      begin
        map[selected_box] := map[selected_box] - 1;
        map[n] := map[n] + 1;
      end else
      begin
        map[selected_box] := map[selected_box] + 1;
        map[n] := map[n] - 1;
      end;

    //Проверка того, что Игрок 1 в Домике
      home1 := True;
      for i := 1 to 18 do
        if map[i] > 0 then
          home1 := False;

    //Проверка того, что Игрок 2 в Домике
      home2 := True;
      for i := 13 to 24 do
        if map[i] < 0 then
          home2 := False;
      for i := 1 to 6 do
        if map[i] < 0 then
          home2 := False;

    //Засчитывание хода со старта
    if (selected_box = (player - 1) * 12 + 1) then
      take_from_start := 1;

    redraw_map[selected_box] := 1;
    selected_box := 0;



  end else



  //Условие возможности хода
  if ((player = 1) and (map[n] > 0)) or ((player = 2) and (map[n] < 0)) then
  begin

    //Выбор клетки

    //Обработка старта!
    if not((n = (player - 1) * 12 + 1) and (take_from_start = 1)) then
    begin
      selected_box := n;
    end;



  end

  else
  begin
    selected_box := 0;

  end;



    //Очистка выделений
  for i := 1 to 24 do
    if color_map[i] <> 0 then
    begin
      color_map[i] := 0;
      redraw_map[i] := 1;
    end;




  //Подсветка выбранной клетки и возможных ходов
    if selected_box > 0 then
  begin

    color_map[selected_box] := 2;
    redraw_map[selected_box] := 1;

    //Проверка кости 1
    if (dice1 > 0) then
    begin
      pos1 := (selected_box - 1 + dice1) mod 24 + 1;

      //Проверка края игрока 1
      if (player = 1) then
        if not((selected_box > 18) and (pos1 < 7)) then
          if (map[selected_box] * map[pos1] >= 0) then
          begin
            color_map[pos1] := 1;
          end;

      //Проверка края игрока 2
      if (player = 2) then
        if not(((selected_box > 6) and (selected_box < 13)) and (pos1 > 12)) then
          if (map[selected_box] * map[pos1] >= 0) then
            color_map[pos1] := 1;

      //Проверка домика 1
      if (player = 1) and (home1) then
      begin
        pos1 := selected_box + dice1;
        if pos1 = 25 then
          color_home1 := 1;
        home1 := True;
        for i := 19 to selected_box - 1 do
          if (map[i] > 0) then
            home1 := False;
        if (home1) and (pos1 > 25) then
          color_home1 := 1;
        home1 := True;
      end;

      //Проверка домика 2
      if (player = 2) and (home2) then
      begin
        pos1 := selected_box + dice1;
        if pos1 = 13 then
          color_home2 := 1;
        home2 := True;
        for i := 7 to selected_box - 1 do
          if (map[i] < 0) then
            home2 := False;
        if (home2) and (pos1 > 13) then
          color_home2 := 1;
        home2 := True;
      end;

    end;

    //Проверка кости 2
    if dice2 > 0 then
    begin
      pos2 := (selected_box - 1 + dice2) mod 24 + 1;
      //Проверка края игрока 1
      if (player = 1) then
        if not((selected_box > 18) and (pos2 < 7)) then
          if (map[selected_box] * map[pos2] >= 0) then
            color_map[pos2] := 1;

      //Проверка края игрока 2
      if (player = 2) then
        if not(((selected_box > 6) and (selected_box < 13)) and (pos2 > 12)) then
          if (map[selected_box] * map[pos2] >= 0) then
            color_map[pos2] := 1;


      //Проверка домика 1
      if (player = 1) and (home1) then
      begin
        pos2 := selected_box + dice2;
        if pos2 = 25 then
          color_home1 := 1;
        home1 := True;
        for i := 19 to selected_box - 1 do
          if (map[i] > 0) then
            home1 := False;
        if (home1) and (pos2 > 25) then
          color_home1 := 1;
        home1 := True;
      end;

      //Проверка домика 2
      if (player = 2) and (home2) then
      begin
        pos2 := selected_box + dice2;
        if pos2 = 13 then
          color_home2 := 1;
        home2 := True;
        for i := 7 to selected_box - 1 do
          if (map[i] < 0) then
            home2 := False;
        if (home2) and (pos2 > 13) then
          color_home2 := 1;
        home2 := True;
      end;
    end;

  end;

  //Отрисовка позиций
  Step(Sender);
end;




//===============================================================Проверка возможности хода!
procedure TForm1.CheckPossibility(Sender: TObject);
var
  i, j: integer;
  N: integer;
  pos1, pos2: integer;
begin

    N := 0;

  for i := 1 to 24 do
    if ((map[i] > 0) and (player = 1)) or
       ((map[i] < 0) and (player = 2))
    then
    begin

      //Проверка кости 1
      if dice1 > 0 then
      begin
        pos1 := (i - 1 + dice1) mod 24 + 1;

        //Проверка края игрока 1
        if (player = 1) then
          if not((i > 18) and (pos1 < 7)) then
            if not((i = 1) and (take_from_start = 1)) then
              if (map[i] * map[pos1] >= 0) then
                inc(N);

        //Проверка края игрока 2
        if (player = 2) then
          if not(((i > 6) and (i < 13)) and (pos1 > 12)) then
            if not((i = 13) and (take_from_start = 1)) then
              if (map[i] * map[pos1] >= 0) then
                inc(N);

        //Проверка домика 1
      if (player = 1) and (home1) then
      begin
        pos1 := i + dice1;
        if pos1 = 25 then
          inc(N)
        else
        if (pos1 > 25) then
        begin
          //Проверка, что сзади нет фишек
          home1 := True;
          for j := 19 to i - 1 do
            if (map[j] > 0) then
              home1 := False;
          if (home1) then
            inc(N);
          home1 := True;
        end;
      end;

      //Проверка домика 2
      if (player = 2) and (home2) then
      begin
        pos1 := i + dice1;
        if (pos1 = 13) then
          inc(N)
        else
        if (pos1 > 13) then
        begin
          //Проверка того, что сзади нет фишек
          home2 := True;
          for j := 7 to i - 1 do
            if (map[j] < 0) then
              home2 := False;
          if (home2) then
            inc(N);
          home2 := True;
        end;
      end;

      end;

      //Проверка кости 2
      if dice2 > 0 then
      begin
        pos2 := (i - 1 + dice2) mod 24 + 1;
        //Проверка края игрока 1
        if (player = 1) then
          if not((i > 18) and (pos2 < 7)) then
            if not((i = 1) and (take_from_start = 1)) then
              if (map[i] * map[pos2] >= 0) then
                inc(N);

        //Проверка края игрока 2
        if (player = 2) then
          if not(((i > 6) and (i < 13)) and (pos2 > 12)) then
            if not((i = 13) and (take_from_start = 1)) then
              if (map[i] * map[pos2] >= 0) then
                inc(N);


        //Проверка домика 1
        if (player = 1) and (home1) then
        begin
          pos2 := i + dice2;
          if pos2 = 25 then
            inc(N)
          else
          if (pos2 > 25) then
          begin
            //Проверка, что сзади нет фишек
            //home1 := True;
            for j := 19 to i - 1 do
              if (map[j] > 0) then
                home1 := False;
            if (home1) then
              inc(N);
            home1 := True;
          end;
      end;

      //Проверка домика 2
      if (player = 2) and (home2) then
      begin
        pos2 := i + dice2;
        if (pos2 = 13) then
          inc(N)
        else
        if (pos2 > 13) then
        begin
          //Проверка того, что сзади нет фишек
          home2 := True;
          for j := 7 to i - 1 do
            if (map[j] < 0) then
              home2 := False;
          if (home2) then
            inc(N);
          home2 := True;
        end;
      end;

    end;

    end;

    if N = 0 then
    begin
      dice1 := 0;
      dice2 := 0;
      ShowMessage('Ход невозможен!');
    end;

    LabelTemp1.Caption := 'Возможных ходов: ' + inttostr(N);

end;

//Отрисовка
procedure TForm1.ReDraw(Sender: TObject);
var
  i: integer;
  TrickBMP, TrickBMP2: TBitmap;
begin

  FillLabel(Image1, 1);
  FillLabel(Image2, 2);
  FillLabel(Image3, 3);
  FillLabel(Image4, 4);
  FillLabel(Image5, 5);
  FillLabel(Image6, 6);
  FillLabel(Image7, 7);
  FillLabel(Image8, 8);
  FillLabel(Image9, 9);
  FillLabel(Image10, 10);
  FillLabel(Image11, 11);
  FillLabel(Image12, 12);
  FillLabel(Image13, 13);
  FillLabel(Image14, 14);
  FillLabel(Image15, 15);
  FillLabel(Image16, 16);
  FillLabel(Image17, 17);
  FillLabel(Image18, 18);
  FillLabel(Image19, 19);
  FillLabel(Image20, 20);
  FillLabel(Image21, 21);
  FillLabel(Image22, 22);
  FillLabel(Image23, 23);
  FillLabel(Image24, 24);

  LabelPlayer.Caption := 'Ход игрока ' + inttostr(player);
  LabelDice1.Caption := inttostr(dice1);
  LabelDice2.Caption := inttostr(dice2);

  //Заполнение Домика 1
  LabelHome1.Repaint;
  TrickBMP := ImageWhite.Picture.Bitmap;

  if color_home1 = 1 then
  begin
    LabelHome1.Canvas.Pen.Color := clGreen;
    LabelHome1.Canvas.Pen.Width := 5;
    LabelHome1.Canvas.Rectangle(Rect(0, 0, 60, 360));
  end;
  for i := 1 to home1_value do
      LabelHome1.Canvas.Draw(0, (i - 1) * 60, TrickBMP);

  //Заполнение Домика 2
  LabelHome2.Repaint;
  TrickBMP2 := ImageBlack.Picture.Bitmap;

  if color_home2 = 1 then
  begin
    LabelHome2.Canvas.Pen.Color := clGreen;
    LabelHome2.Canvas.Pen.Width := 5;
    LabelHome2.Canvas.Rectangle(Rect(0, 300, 60, 665));
  end;
  for i := 1 to home2_value do
      LabelHome2.Canvas.Draw(0, 600 - (i - 1) * 60, TrickBMP2);

end;

//Заполнение одного поля
procedure TForm1.FillLabel(Lab: TImage; n: integer);
var
  i, x: integer;
  c: Char;
  TrickBMP: TBitmap;
begin

  //Нужно перерисовать???
  if (redraw_map[n] = 1) or (color_map[n] <> 0) then
  begin

  lab.Canvas.FillRect(lab.Canvas.ClipRect);

  if map[n] > 0 then
    if color_map[n] = 2 then
      TrickBMP := ImageWhiteSelected.Picture.Bitmap
    else
      TrickBMP := ImageWhite.Picture.Bitmap
  else
    if color_map[n] = 2 then
      TrickBMP := ImageBlackSelected.Picture.Bitmap
    else
      TrickBMP := ImageBlack.Picture.Bitmap;
  x := abs(map[n]);

  if (n = selected_box) then
    x := x - 1;

  if color_map[n] = 1 then
  begin
    lab.Canvas.Brush.Color := clGreen;
    lab.Canvas.Rectangle(Rect(0, 0, 60, 360));
  end;
  if color_map[n] = 2 then
  begin
    lab.Canvas.Brush.Color := clMoneyGreen;
    lab.Canvas.Rectangle(Rect(0, 0, 60, 360));
  end;

  for i := 1 to x do
  begin
    if (n > 12) then
      Lab.Canvas.Draw(0, 300 - (i - 1) * (64 - x * 3), TrickBMP)
    else
      Lab.Canvas.Draw(0, (i - 1) * (64 - x * 3), TrickBMP);
  end;


  redraw_map[n] := 0;
  end;

end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  Select(Sender, 1);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
  Select(Sender, 2);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
  Select(Sender, 3);
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  Select(Sender, 4);
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
 Select(Sender, 5);
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
  Select(Sender, 6);
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
  Select(Sender, 7);
end;

procedure TForm1.Label8Click(Sender: TObject);
begin
  Select(Sender, 8);
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
  Select(Sender, 9);
end;

procedure TForm1.Label10Click(Sender: TObject);
begin
  Select(Sender, 10);
end;

procedure TForm1.Label11Click(Sender: TObject);
begin
  Select(Sender, 11);
end;

procedure TForm1.Label12Click(Sender: TObject);
begin
  Select(Sender, 12);
end;

procedure TForm1.Label13Click(Sender: TObject);
begin
  Select(Sender, 13);
end;

procedure TForm1.Label14Click(Sender: TObject);
begin
  Select(Sender, 14);
end;

procedure TForm1.Label15Click(Sender: TObject);
begin
  Select(Sender, 15);
end;

procedure TForm1.Label16Click(Sender: TObject);
begin
  Select(Sender, 16);
end;

procedure TForm1.Label17Click(Sender: TObject);
begin
  Select(Sender, 17);
end;

procedure TForm1.Label18Click(Sender: TObject);
begin
  Select(Sender, 18);
end;

procedure TForm1.Label19Click(Sender: TObject);
begin
  Select(Sender, 19);
end;

procedure TForm1.Label20Click(Sender: TObject);
begin
  Select(Sender, 20);
end;

procedure TForm1.Label21Click(Sender: TObject);
begin
  Select(Sender, 21);
end;

procedure TForm1.Label22Click(Sender: TObject);
begin
  Select(Sender, 22);
end;

procedure TForm1.Label23Click(Sender: TObject);
begin
  Select(Sender, 23);
end;

procedure TForm1.Label24Click(Sender: TObject);
begin
  Select(Sender, 24);
end;

procedure TForm1.LabelHome1Click(Sender: TObject);
var
  i: integer;
begin
  if (color_home1 = 1) then
  begin

    redraw_map[selected_box] := 1;

    //Ход костью 1?
    if (selected_box + dice1) >= 25 then
    begin
      ProgressBar1.Position := ProgressBar1.Position + dice1;
      dice1 := 0;
    end
    else  //Ход костью 2?
    begin
      ProgressBar1.Position := ProgressBar1.Position + dice2;
      dice2 := 0;
    end;

    //Ход
    map[selected_box] := map[selected_box] - 1;
    home1_value := home1_value + 1;

    selected_box := 0;

    color_home1 := 0;

    //Очистка выделений
    for i := 1 to 24 do
      color_map[i] := 0;


    //Обработка победы!
    if home1_value = 15 then
      ShowMessage('Победил Игрок 1 !!!');
    if abs(home2_value) = 15 then
      ShowMessage('Победил Игрок 2 !!!');

    //Смена игрока! (точнее, проверка)
    Step(Sender);
    ReDraw(Sender);
  end;
end;

procedure TForm1.LabelHome2Click(Sender: TObject);
var
  i: integer;
begin
  if (color_home2 = 1) then
  begin

    redraw_map[selected_box] := 1;

    //Ход костью 1?
    if (selected_box + dice1) >= 13 then
    begin
      ProgressBar2.Position := ProgressBar2.Position + dice1;
      dice1 := 0;
    end
    else  //Ход костью 2?
    begin
      ProgressBar2.Position := ProgressBar2.Position + dice2;
      dice2 := 0;
    end;

    //Ход
    map[selected_box] := map[selected_box] + 1;
    home2_value := home2_value + 1;

    selected_box := 0;

    color_home2 := 0;

    //Очистка выделений
    for i := 1 to 24 do
      color_map[i] := 0;

    //Обработка победы!
    if home1_value = 15 then
      ShowMessage('Победил Игрок 1 !!!');
    if abs(home2_value) = 15 then
      ShowMessage('Победил Игрок 2 !!!');

    //Смена игрока! (точнее, проверка)
    Step(Sender);
    ReDraw(Sender);
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;


//Кинуть кубики!
procedure TForm1.ButtonDropClick(Sender: TObject);
begin
    dice1 := RandomRange(1, 6);
    dice2 := RandomRange(1, 6);

    ButtonDrop.Hide;
    Step(Sender);
end;

procedure TForm1.TimerMouseTimer(Sender: TObject);
begin
  //Белый курсор
  if (selected_box > 0) and (player = 1) then
  begin
    ImageWhiteSelected.Show;
    ImageWhiteSelected.Left := Mouse.CursorPos.X - Form1.Left - 10;
    ImageWhiteSelected.Top := Mouse.CursorPos.Y - Form1.Top - 20;
  end
  else
  begin
    ImageWhiteSelected.Hide;
  end;

  //Чёрный курсор
  if (selected_box > 0) and (player = 2) then
  begin
    ImageBlackSelected.Show;
    ImageBlackSelected.Left := Mouse.CursorPos.X - Form1.Left - 10;
    ImageBlackSelected.Top := Mouse.CursorPos.Y - Form1.Top - 20;
  end
  else
    ImageBlackSelected.Hide;
end;

end.
