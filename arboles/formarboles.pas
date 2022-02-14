unit formarboles;

{$mode objfpc}{$H+}

interface

uses
  TAD_tipos, arbolm_hei_hd, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  a: arbol;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  a.crearvacio;
  a.cargar;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  a.graficar(Image1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  a.crearvacio;
end;

end.

