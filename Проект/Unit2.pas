unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TFormMenu = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    ButtonStart: TButton;
    procedure ButtonStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenu: TFormMenu;

implementation

uses Unit1;

{$R *.dfm}

procedure TFormMenu.ButtonStartClick(Sender: TObject);
begin
  Form1.Show;
  Random;
  Randomize;
  Form1.NewGame(Sender);
  Hide;
end;

procedure TFormMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

end.
