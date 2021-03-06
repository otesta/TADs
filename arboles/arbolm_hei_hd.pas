unit Arbolm_hei_hd;

{$mode objfpc}{$H+}

interface

uses
  tad_Tipos, Classes, LResources, Forms, Controls, Graphics, Dialogs,
  MaskEdit, StdCtrls, ExtCtrls, Process;

const
  Min=1;
  Max=100;
  Nulo=Nil;

Type
  posicionarbol = ^nodo_arbol;
  nodo_arbol = Record
    datos: tipoelemento;
    hei,hd: posicionarbol;
    fe: -1..1;
  end;

  arbol = object
        raiz: posicionarbol;
        qitem:longint;
  procedure crearvacio;
  function Esvacio():Boolean;
  function Eslleno():Boolean;
  function ramanula(p:posicionarbol):Boolean;
  procedure preorden(a: posicionarbol; var mm:TMemo);
  procedure inorden(a: posicionarbol; var mm:Tmemo);
  procedure postorden(a: posicionarbol; var mm:Tmemo);
  procedure cargar;
  function recuperar(a:posicionarbol; var x:tipoelemento):errores;
  function busqueda(x:tipoelemento; Comparar:Campo_Comparar): posicionarbol;
  function hijoExtremoIzq(p:posicionarbol):posicionarbol;
  function hermanoDer(p:posicionarbol):posicionarbol;
  function padre(p:posicionarbol):posicionarbol;
  function altura(p:posicionarbol):integer;
  function nivel(p:posicionarbol):integer;
  procedure recorrer_graficar(a:posicionarbol; var FileVar: TextFile);
  procedure graficar(lugar_grafico:TImage);
  end;

implementation

procedure arbol.crearvacio;
begin
  raiz:= Nulo;
  qitem:=0;
end;

function arbol.esvacio():boolean;
begin
  esvacio:= (raiz=nulo);
end;

function arbol.eslleno():boolean;
begin
  eslleno:= (qitem=max);
end;

function arbol.ramanula(p:posicionarbol):boolean;
begin
  ramanula:=(p=nulo);
end;

function arbol.hijoExtremoIzq (p:posicionarbol):posicionarbol;
begin
  if not ramanula(p) then
  hijoExtremoIzq:=p^.hei;
end;

function arbol.hermanoDer (p:posicionarbol):posicionarbol;
begin
  if not ramanula(p) then
  hermanoDer:=p^.hd;
end;

function arbol.recuperar (a:posicionarbol; var x:tipoelemento):errores;
begin
  recuperar:=posicioninvalida;
  if not ramanula (a) then
     begin
       x.asignarvalores(a^.datos);
       recuperar:=ok;
     end;
end;

procedure arbol.preorden (a:posicionarbol; var mm:Tmemo);
var
   c:posicionarbol;
   s:string;
   procedure mostarNodo (a:posicionarbol);
   var
      s1:string;
   begin
     s:= a^.datos.ds + ' - ';
     str(a^.datos.dn, s1);
     s:=s+s1+' - ';
     str(a^.datos.dr:4:2, s1);
     s:=s+s1+' - ';
     mm.Lines.add(s);
   end;
begin
  if ramanula (a) then
     mm.lines.add('.')
  else
     begin
       mostarNodo(a);
       c:=hijoExtremoIzq(a);
       while c <> Nulo do
       begin
         preorden(c, mm);
         c:= hermanoDer(c);
       end;
     end;
end;

procedure arbol.inorden (a:posicionarbol; var mm:tmemo);
var
   c:posicionarbol;
   s:string;
   procedure mostarNodo (a:posicionarbol);
   var
      s1:string;
   begin
     s:= a^.datos.ds + ' - ';
     str(a^.datos.dn, s1);
     s:=s+s1+' - ';
     str(a^.datos.dr:4:2, s1);
     s:=s+s1+' - ';
     mm.Lines.add(s);
   end;
begin
  if ramanula (a) then
     mm.lines.add('.')
  else
     begin
       c:=hijoExtremoIzq(a);
       inorden(c, mm);
       mostarNodo(a);
       c:=hermanoDer(c);
       while c <> Nulo do
       begin
         inorden(c, mm);
         c:= hermanoDer(c);
       end;
     end;
end;

procedure arbol.postorden (a:posicionarbol; var mm:Tmemo);
var
   c:posicionarbol;
   s:string;
   procedure mostarNodo (a:posicionarbol);
   var
      s1:string;
   begin
     s:= a^.datos.ds + ' - ';
     str(a^.datos.dn, s1);
     s:=s+s1+' - ';
     str(a^.datos.dr:4:2, s1);
     s:=s+s1+' - ';
     mm.Lines.add(s);
   end;
begin
  if ramanula (a) then
     mm.lines.add('.')
  else
     begin
       c:=hijoExtremoIzq(a);
       while c <> Nulo do
       begin
         postorden(c, mm);
         c:= hermanoDer(c);
       end;
       mostarNodo(a);
     end;
end;

procedure arbol.cargar;
var
   x:tipoelemento;
   c:posicionarbol;
   s:string;

procedure carga(var a:posicionarbol);
  begin
    x.ds:= inputbox('Datos', 'Ingrese', '.');
    if x.ds='.' then
       a:=nulo
    else
       begin
         new (a);
         a^.datos.asignarvalores(x);
         inc(qitem);
         carga(a^.hei);
         x.ds:='-';
         while x.DS <> '.' do
               carga(a^.hd);
       end;
  end;
begin
  carga(raiz);
end;

function arbol.busqueda(x:tipoelemento; comparar:Campo_comparar):posicionarbol;
var
   p:posicionarbol;
procedure encontrar(a: posicionarbol);
var
   c:posicionarbol;
begin
  if not ramanula(a) then
     if x.compararTE(a^.datos, comparar) = igual then
        p:=a
     else
        begin
          c:=hijoExtremoIzq(a);
          while c <> Nulo do
          begin
            encontrar(c);
            c:=hermanoder(c);
          end;
        end;
end;
begin
  p:=nulo;
  encontrar(Raiz);
  busqueda:=p;
end;

function arbol.padre(p:posicionarbol):posicionarbol;
var
   pad:posicionarbol;

   function EsHijo(p,a:posicionarbol):Boolean;
   var
      d:posicionarbol;
      Enc:boolean;
   begin
      Enc:=false;
      d:=hijoextremoizq(a);
      while (d <> Nulo) and (Not Enc) do
      if p=d then
         enc:=true
      else
          d:=hermanoDer(d);
      EsHijo:=Enc;
   end;

   procedure encontrarPadre(a:posicionarbol);
   var
      c:posicionarbol;
   begin
     if not ramanula(a) then
        if EsHijo(p,a) then
           pad:=a
        else
            begin
              c:= hijoExtremoIzq(a);
              while c<>Nulo do
              begin
                encontrarPadre(c);
                c:=hermanoDer(c);
              end;
            end;
   end;

begin
  pad:=nulo;
  if p<>Raiz then
     encontrarpadre(p);
  padre:=pad;
end;

function arbol.nivel(p:posicionarbol):integer;
var
   n:integer;
   enc:boolean;

   function EsHijo(p,a:posicionarbol):Boolean;
   var
      d:posicionarbol;
      Enc:boolean;
   begin
      Enc:=false;
      d:=hijoextremoizq(a);
      while (d <> Nulo) and (Not Enc) do
      if p=d then
         enc:=true
      else
          d:=hermanoDer(d);
      EsHijo:=Enc;
   end;

   procedure encontrarNivel(a:posicionarbol; n:integer);
   var
      c:posicionarbol;
   begin
     if not ramanula(a) then
        begin
             inc(n);
             if EsHijo(p,a) then
                 begin
                      nivel:=n
                 end
             else
                 begin
                      c:= hijoExtremoIzq(a);
                      while c<>Nulo do
                            begin
                                 encontrarNivel(c, n);
                                 c:=hermanoDer(c);
                            end;
                 end;
        end;
   end;
begin
  n:=0;
  nivel:=0;
  if p<>raiz then
      encontrarNivel(raiz, n);
end;

function arbol.altura(p:posicionarbol):integer;
var
   n:integer;
   enc:boolean;

   procedure encontrarAltura(a:posicionarbol; n:integer);
   var
      c:posicionarbol;
   begin
     if not ramanula(a) then
        begin
             inc(n);
             c:= hijoExtremoIzq(a);
             while c<>Nulo do
                   begin
                        encontrarAltura(c, n);
                        c:=hermanoDer(c);
                   end;
             if n > altura then
	        altura:=n-1;
        end;
   end;
begin
  n:=0;
  altura:=0;
  if p<>nulo then
      encontrarAltura(p, n);
end;


procedure arbol.graficar(lugar_grafico:TImage);
var
UnProceso: TProcess;
picture1: TPicture;
FileVar: TextFile;
begin
// Genero el archivo para mostrar la lista desde GraphViz
AssignFile(FileVar, './Test.txt');
try
 Rewrite(FileVar);  // creating the file
 Writeln(FileVar,'digraph G{');
 recorrer_graficar(raiz,FileVar);
 Writeln(FileVar,'}');
except
// Writeln('ERROR! IORESULT: ' + IntToStr(IOResult));
end;
CloseFile(FileVar);


// Ahora creamos UnProceso.
UnProceso := TProcess.Create(nil);

// Asignamos a UnProceso la orden que debe ejecutar.
UnProceso.CommandLine := 'dot -Tpng ./Test.txt -o ./lista.png';
UnProceso.Options := UnProceso.Options + [poWaitOnExit, poUsePipes];

// Lanzamos la ejecuci??n ...
UnProceso.Execute;

// Nuestro programa se detiene hasta que 'ppc386' finaliza.
UnProceso.Free;

// Muestro el resultado del graphviz
picture1 := TPicture.Create;
picture1.LoadFromFile('./lista.png');
lugar_grafico.Picture.Assign(picture1);
end;


procedure arbol.recorrer_graficar(a:posicionarbol; var FileVar: TextFile);
var
   c:posicionarbol;
   x,y:tipoelemento;
   s:string;
begin
  if not ramanula (a) then
     begin
       recuperar(a,x);
       if (not ramanula(hijoExtremoIzq(a))) then
          begin
            c:=hijoExtremoIzq(a);
            while c <> Nulo do
            begin
              recuperar(c,y);
              Writeln(FileVar,'"' + x.ds + '"->' + '"' + y.ds + '"');
              recorrer_graficar(c, FileVar);
              c:= hermanoDer(c);
            end;
          end;
     end;
end;


end.

