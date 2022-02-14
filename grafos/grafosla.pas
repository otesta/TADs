unit GrafosLA;

{$mode objfpc}{$H+}

interface

uses
  Classes, LResources, Forms, Controls, Graphics, Dialogs,
  MaskEdit, StdCtrls, ExtCtrls, tad_tipos, PilasPunteros, Colacursores,TAD_listas_punteros,Process;

const
  Min=1;
  Max=100;
  Nulo=0;

Type
  posiciongrafo = longint;
  nodo_grafo = record
    Datos:tipoelemento;
    Adyacentes:lista;
  end;

  Grafo = Object
    LA: array[Min..Max] of nodo_grafo;
    nvertices: longint;
  procedure crearvacio;
  function Esvacio():Boolean;
  function Eslleno():Boolean;
  function VerticeValido(a:posiciongrafo):Boolean;
  function VerticeAislado(x:tipoelemento):Boolean;
  function agregarVertice(x:tipoelemento; comparar:campo_comparar):errores;
  function GradoSalVertice(x:tipoelemento; comparar:campo_comparar):integer;
  function GradoEntVertice(x:tipoelemento; comparar:campo_comparar):integer;
  function buscarVertice(x:tipoelemento; comparar:campo_comparar):posiciongrafo;
  function recuperarVertice(a:posiciongrafo; var x:tipoelemento):errores;
  function eliminarVertice(x:tipoelemento; comparar:campo_comparar):errores;
  function agregarArco(x1,x2:tipoelemento; comparar:campo_comparar):errores;
  function eliminarArco(x1,x2:tipoelemento; comparar:campo_comparar):errores;
  function recuperarArco(i,j:posiciongrafo; var x:tipoelemento):errores;
  procedure recorridoProfundidad(x1:tipoelemento; comparar:campo_comparar; var MM:tmemo);
  procedure recorridoAnchura(x1:tipoelemento; comparar:campo_comparar; var MM:tmemo);
  procedure graficar(lugar_grafico:TImage);
  procedure recorrer_graficar(var FileVar: TextFile);
  Function Entrantes(A:posiciongrafo; Var  LE:Lista): Errores;
  Function Salientes(A:posiciongrafo; Var LS: Lista): Errores;
  end;

implementation

procedure grafo.crearvacio;
var i:posiciongrafo;
begin
  for i:=Min to Max do
      begin
           LA[i].Datos.Inicializar;
           LA[i].Adyacentes.Crearvacia;
      end;
  nvertices:=0;
end;

function grafo.esvacio():boolean;
begin
  esvacio:= (nvertices=nulo);
end;

function grafo.eslleno():boolean;
begin
  eslleno:= (nvertices=max);
end;

function grafo.VerticeValido(a:posiciongrafo):Boolean;
begin
  VerticeValido:=(a>=min) and (a<= nvertices);
end;

function grafo.VerticeAislado(x:tipoelemento):Boolean;
var i:posiciongrafo;
    x1:tipoelemento;
begin
  VerticeAislado:=True;
  x1.DN:= buscarVertice(x, campo1);
  if verticeValido(x1.DN) then
     begin
          for i:=Min to max do
              if LA[i].Adyacentes.Buscar(x1, campo2)<>nil then
                  VerticeAislado:=False;
     end
  else
      VerticeAislado:=False;
end;

function grafo.GradoSalVertice(x:tipoelemento; comparar:campo_comparar):integer;
var p:posiciongrafo;
begin
   GradoSalVertice:=0;
   p:= buscarVertice(x, campo1);
   if verticeValido(p) then
   GradoSalVertice:= LA[p].Adyacentes.q_items;
end;

function grafo.GradoEntVertice(x:tipoelemento; comparar:campo_comparar):integer;
var i,p:posiciongrafo;
    x1:tipoelemento;
begin
   GradoEntVertice:=0;
   x1.DN:= buscarVertice(x, campo1);
   if verticeValido(x1.DN) then
     begin
          for i:=Min to max do
              if i<>x1.DN then
              if LA[i].Adyacentes.Buscar(x1, campo2)<>nil then
                  inc(GradoEntVertice);
     end
end;

function grafo.buscarVertice(x:tipoelemento; comparar:campo_comparar):posiciongrafo;
var
  i:posiciongrafo;
  Enc:boolean;
begin
  buscarVertice:=Nulo;
  i:=min;
  enc:=false;
  while (i<= nvertices) and (not enc) do
        if x.CompararTE(LA[i].Datos, comparar)=igual then
           begin
                buscarVertice:=i;
                enc:=true;
           end
        else
           inc(i);
end;
function grafo.agregarVertice(x:tipoelemento; comparar:campo_comparar):errores;
begin
  if eslleno then
     agregarvertice:= Lleno
  else
    if buscarVertice(x, comparar)<> nulo then
       agregarVertice:= Posicioninvalida
    else
      begin
           inc(nvertices);
           LA[nvertices].Datos.AsignarValores(x);
           LA[nvertices].Adyacentes.Crearvacia;
           agregarVertice:=ok;
      end;
end;

function grafo.recuperarVertice(a:posiciongrafo; var x:tipoelemento):errores;
begin
  recuperarVertice:=Posicioninvalida;
  if verticevalido(a) then
     begin
          x.AsignarValores(LA[a].Datos);
          recuperarVertice:=Ok;
     end;
end;

function grafo.eliminarVertice(x:tipoelemento; comparar:campo_comparar):errores;
var v, i: posiciongrafo; p:posicion_lista; x1:tipoelemento;
begin
  if esvacio then
     eliminarVertice:= Vacio
  else
      begin
           v:=buscarVertice(x, comparar);
           if v=nulo then
              eliminarVertice:=posicioninvalida
           else
             begin
                  for i:= v to nvertices-1 do
                      LA[i]:=LA[i+1];
                  dec(nvertices);
                  x1.DN:=v;
                  for i:=min to nvertices do
                      begin
                           p:=LA[i].Adyacentes.Buscar(x1, campo2);
                           if p<> nil then
                              LA[i].Adyacentes.Eliminar(p);
                      end;
                  eliminarVertice:=ok;
             end;
      end;

end;

function grafo.agregarArco(x1,x2:tipoelemento; comparar:campo_comparar):errores;
var i, j: posiciongrafo; x:tipoelemento;
begin
  agregarArco:= posicioninvalida;
  i:= buscarVertice(x1, comparar);
  j:= buscarVertice(x2, comparar);
  if (i<>nulo) and (j<>nulo) then
     begin
          x.DN:=j;
          if LA[i].Adyacentes.Buscar(x, campo2)=nil then
             begin
                  LA[i].Adyacentes.Agregar(x);
                  agregarArco:=ok;
             end
          else
              agregarArco:=otro;
     end;
end;

function grafo.eliminarArco(x1,x2:tipoelemento; comparar:campo_comparar):errores;
var i,j:posiciongrafo; x:tipoelemento; p:posicion_lista;
begin
  eliminarArco:= posicioninvalida;
  i:= buscarVertice(x1, comparar);
  j:= buscarVertice(x2, comparar);
  if (i<>nulo) and (j<>nulo) then
     begin
          x.DN:=j;
          p:=LA[i].Adyacentes.Buscar(x, campo2);
          if p<>nil then
             begin
                  LA[i].Adyacentes.Eliminar(p);
                  eliminarArco:=ok;
             end;
     end;
end;

function grafo.recuperarArco(i,j:posiciongrafo; var x:tipoelemento):errores;
var p:posicion_lista; x1:tipoelemento;
begin
  recuperarArco:=posicioninvalida;
  if verticeValido(i) and verticeValido(j) then
     begin
          x1.DN:=j;
          p:=LA[i].Adyacentes.Buscar(x1, campo2);
          if p<>nil then
             begin
                  LA[i].Adyacentes.Recuperar(p, x);
                  recuperarArco:=ok;
             end
          else
              recuperarArco:=otro;

     end;
end;

Function grafo.Entrantes(A:PosicionGrafo; Var  LE:Lista): Errores;
var j: integer;
    x,y: tipoelemento;
    pl: posicion_lista;
Begin
LE.CrearVacia;
If not VerticeValido(a) then
	Entrantes:= PosicionInvalida
Else
	begin
        x.dn:= a;
	For  j:= 1 to NVertices do
            begin
                 pl:= LA[j].Adyacentes.Buscar(x, campo2);
		If pl<> nil then
                    begin
                    Y.DN:= J;
		   LE.Agregar(y);
		   end;
            end;
        Entrantes:= ok;
        end;
end;

Function grafo.Salientes(A:PosicionGrafo; Var LS: Lista): Errores;
begin
LS.CrearVacia;
If not VerticeValido(a) then
	Salientes:= PosicionInvalida
Else
	begin
        LS:= LA[a].Adyacentes;
	Salientes:= OK
	end;
end;
procedure grafo.recorridoProfundidad(x1:tipoelemento; comparar:campo_comparar; var MM:tmemo);
var i, j:posiciongrafo; l, ls:lista; p:pila; x:tipoelemento; pl, li:posicion_lista;
begin
  mm.clear;
  i:= buscarVertice(x1, comparar);
  if i <> nulo then
     begin
          p.Crearvacia;
          l.Crearvacia;
          x.DN:=i;
          p.Apilar(x);
          while not p.Esvacia() do
                begin
                 p.Recuperartope(x);
                 p.Desapilar();
                 mm.Lines.Add(LA[x.DN].Datos.DS);
                 l.Agregar(x);
                 Salientes(x.Dn, LS);
                 li:= LS.Inicio;
                 While(li<> nil) do
                       Begin
                       LS.Recuperar(li, x);
                       if (l.Buscar(x, campo2)=nil) then
                           p.Apilar(x);
                         li:=LS.siguiente(li);
                       end;
                end;
     end;
end;

procedure grafo.recorridoAnchura(x1:tipoelemento; comparar:campo_comparar; var MM:tmemo);
var i, j:posiciongrafo; l, ls:lista; c:cola; x:tipoelemento; pl, li:posicion_lista;
begin
  mm.clear;
  i:= buscarVertice(x1, comparar);
  if i <> nulo then
     begin
          c.Crearvacia;
          l.Crearvacia;
          x.DN:=i;
          c.Encolar(x);
          while not c.Esvacia() do
                begin
                     c.Recuperarfrente(x);
                     c.Desencolar();
                     mm.Lines.Add('vertice' + LA[x.DN].Datos.DS);
                     l.Agregar(x);
                     Salientes(x.Dn, LS);
                     li:= LS.Inicio;
                     While(li <> nil) do
                           Begin
                                LS.Recuperar(li, x);
                                if (l.Buscar(x, campo2)=nil) then
                                    c.Encolar(x);
                                  li:=LS.siguiente(li);
                           end;
                end;
     end;
end;


procedure grafo.graficar(lugar_grafico:TImage);
var
UnProceso: TProcess;
picture1: TPicture;
FileVar: TextFile;
i:integer;
begin
// Genero el archivo para mostrar la lista desde GraphViz
AssignFile(FileVar, './Test.txt');
try
 Rewrite(FileVar);  // creating the file
 Writeln(FileVar,'digraph G{');
 recorrer_graficar(FileVar);
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

// Lanzamos la ejecución ...
UnProceso.Execute;

// Nuestro programa se detiene hasta que 'ppc386' finaliza.
UnProceso.Free;

// Muestro el resultado del graphviz
picture1 := TPicture.Create;
picture1.LoadFromFile('./lista.png');
lugar_grafico.Picture.Assign(picture1);
end;

  procedure grafo.recorrer_graficar(var FileVar: TextFile);
  var i,j:posiciongrafo; l, ls:lista; p:pila; x,lx:tipoelemento; pl:posicion_lista;
  begin

  // Primero imprimo los vertices
  for i:=MIN to nvertices do
    begin
      Writeln(FileVar,'"' + LA[i].Datos.DS + '"');
    end;


  l.Crearvacia;
   for i:=MIN to nvertices do
   begin
     p.Crearvacia;
     x.inicializar;
     x.DN:=i;
     x.DS:= LA[i].Datos.DS;
     if (l.Buscar(x, campo2) = nil) then
       begin
         p.Apilar(x);
         while not p.Esvacia() do
           begin
             p.Recuperartope(x);
             p.Desapilar();
             l.Agregar(x);
             Salientes(x.DN, ls);
             pl:=ls.inicio;
             while (pl <> nil) do
               begin
                 ls.recuperar(pl,lx);
                 recuperarvertice(lx.DN,lx);
                 Writeln(FileVar,'"' + x.DS + '"->' + '"' + lx.DS + '"' + '[label="vinculo"]');
                 if (l.Buscar(lx, campo2) = nil) then
                   begin
                     p.Apilar(lx);
                   end;
                 pl:=ls.siguiente(pl);
               end;
           end;
       end;
   end;

  end;

end.
