unit formgrafos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, TAD_tipos, grafosla;

type

  { TForm1 }

  TForm1 = class(TForm)
    addVertice: TButton;
    addArco: TButton;
    graficar: TButton;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    vhasta: TEdit;
    vertice: TEdit;
    Label1: TLabel;
    vdesde: TEdit;
    procedure addArcoClick(Sender: TObject);
    procedure addVerticeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure graficarClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  G: grafo;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  G.crearvacio;
end;

procedure TForm1.graficarClick(Sender: TObject);
begin
  G.graficar(Image1);
end;

procedure TForm1.addVerticeClick(Sender: TObject);
var
  x:tipoelemento;
begin
  x.Inicializar;
  x.ds := vertice.Text;
  G.agregarVertice(x,campo1);
end;

procedure TForm1.addArcoClick(Sender: TObject);
var
  x,y: tipoelemento;
begin
  x.Inicializar;
  y.Inicializar;
  x.ds :=vdesde.text;
  y.ds:=vhasta.text ;
  G.agregarArco(x,y,campo1);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

end.

