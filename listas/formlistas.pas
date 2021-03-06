unit FormListas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, MaskEdit, Buttons, dynlibs, TAD_tipos, TAD_listas_punteros,
  ExtCtrls, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    btn_insertar_posicion: TButton;
    btn_agregar: TButton;
    btn_mostrar_grafico: TButton;
    estado_lista: TEdit;
    Image1: TImage;
    Label4: TLabel;
    vstring: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ventero: TMaskEdit;
    posicion: TMaskEdit;
    procedure btn_insertar_posicionClick(Sender: TObject);
    procedure btn_agregarClick(Sender: TObject);
    procedure btn_mostrar_graficoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  L: lista;


implementation

{ TForm1 }
procedure limpiar();
begin
  Form1.vstring.Text:='';
  Form1.ventero.Text:='';
  Form1.posicion.Text:='';
end;

function encontrar_posicion(L: lista; posicion: integer): posicion_lista;
var i: integer;
    q: posicion_lista;
begin
  q:=L.inicio;
  for i:=1 to (posicion-1) do
    q:=L.siguiente(q);
  encontrar_posicion:=q;
end;

procedure TForm1.GroupBox1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  libreria: TLibHandle;
begin
  L.crearvacia();
  libreria:=dynlibs.LoadLibrary('/usr/lib/graphviz/libgvplugin_core.so');

end;

procedure TForm1.btn_agregarClick(Sender: TObject);
var x: TipoElemento;
    cod, resul: integer;
    p: posicion_lista;
    pru: ^integer;
begin
  x.Inicializar;

  // En este script se agrega un elemento a la lista ...
  if (Form1.vstring.Text <> '') then
    begin
      val(Form1.ventero.Text,resul,cod);
      pru:=@resul;
      showmessage(inttostr(pru^));
      x.DN:= resul;
      x.DS:= Form1.vstring.Text;

          L.agregar(x);
          limpiar();
    end;
  L.imprimir(campo1y2,Form1.estado_lista);
end;

procedure TForm1.btn_insertar_posicionClick(Sender: TObject);
  var x: TipoElemento;
      cod, resul: integer;
      p: posicion_lista;
  begin
    x.Inicializar;

    // En este script se agrega un elemento a la lista ...
    if (Form1.vstring.Text <> '') then
      begin
        val(Form1.ventero.Text,resul,cod);
        x.DN:= resul;
        x.DS:= Form1.vstring.Text;

        // En este punto decido si lo inserto en una posici??n determinada o no...
        val(Form1.posicion.Text,resul,cod);
        if (resul > 0) and (cod = 0) then
          begin
            if (resul < L.q_items) then
              begin
                p:=encontrar_posicion(L,resul);
                L.insertar(x,p);
                limpiar();
              end
            else
              begin
                L.agregar(x);
                limpiar();
              end;
          end
        else
          showmessage('No es correcta la posici??n donde quiere insertar el elemento');
      end;
    L.imprimir(campo1y2,Form1.estado_lista);

end;

procedure TForm1.btn_mostrar_graficoClick(Sender: TObject);
var
   picture1: TPicture;
   i: integer;
   FileVar: TextFile;
   p: posicion_lista;
   si,anterior: string;
   links: string;
   x,y: tipoelemento;
begin
   L.graficar(Form1.Image1);

end;

initialization
  {$I formlistas.lrs}

end.

