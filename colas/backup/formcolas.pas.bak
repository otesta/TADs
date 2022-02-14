unit formcolas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, MaskEdit, Buttons, dynlibs, TAD_tipos, TAD_colas_punteros,
  ExtCtrls, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    btn_agregar: TButton;
    btn_mostrar_grafico: TButton;
    estado_pila: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ventero: TMaskEdit;
    vstring: TEdit;
    procedure btn_agregarClick(Sender: TObject);
    procedure btn_mostrar_graficoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  C: Cola;

implementation

{$R *.lfm}
 { TForm1 }
procedure limpiar();
begin
  Form1.vstring.Text:='';
  Form1.ventero.Text:='';
end;

{ TForm1 }

procedure TForm1.Label4Click(Sender: TObject);
begin

end;

procedure TForm1.btn_agregarClick(Sender: TObject);
  var x: TipoElemento;
      cod, resul: integer;
  begin
    x.Inicializar;

    // En este script se agrega un elemento a la pila ...
    if (Form1.vstring.Text <> '') then
      begin
        val(Form1.ventero.Text,resul,cod);
        x.DN:= resul;
        x.DS:= Form1.vstring.Text;

        C.Encolar(x);
        limpiar();
      end;
     // p.imprimir(campo1y2,Form1.estado_pila);
end;

procedure TForm1.btn_mostrar_graficoClick(Sender: TObject);
  begin
     C.graficar(Image1);
end;

procedure TForm1.FormCreate(Sender: TObject);
  var
    libreria: TLibHandle;
  begin
    C.crearvacia();
    libreria:=dynlibs.LoadLibrary('/usr/lib/graphviz/libgvplugin_core.so');

end;

end.

