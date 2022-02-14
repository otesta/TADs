unit GrafosMA;

{$mode objfpc}{$H+}

interface

uses
  TAD_Tipos, Classes, LResources, Forms, Controls, Graphics, Dialogs,
  MaskEdit, StdCtrls, ExtCtrls, TAD_listas_punteros, PilasPunteros, Colacursores,Process;

const
  Min=1;
  Max=100;
  Nulo=0;

Type
  posiciongrafo = longint;
  Grafo = Object
    vertices: array[Min..Max] of tipoelemento;
    MA: array[Min..Max, Min..Max] of tipoelemento;
    nvertices: longint;
  procedure crearvacio;
  function Esvacio():Boolean;
  function Eslleno():Boolean;
  function VerticeValido(a:posiciongrafo):Boolean;
  function VerticeAislado(x:tipoelemento;comparar:campo_comparar):Boolean;
  function agregarVertice(x:tipoelemento; comparar:campo_comparar):errores;
  function buscarVertice(x:tipoelemento; comparar:campo_comparar):posiciongrafo;
  function recuperarVertice(a:posiciongrafo; var x:tipoelemento):errores;
  function eliminarVertice(x:tipoelemento; comparar:campo_comparar):errores;
  function GradoEntVertice(x:tipoelemento; comparar:campo_comparar):integer;
  function GradoSalVertice(x:tipoelemento; comparar:campo_comparar):integer;
  function agregarArco(x,y:tipoelemento; comparar:campo_comparar):errores;
  function eliminarArco(x,y:tipoelemento; comparar:campo_comparar):errores;
  function recuperarArco(i,j:posiciongrafo; var x:tipoelemento):errores;
  procedure recorridoProfundidad(x1:tipoelemento; comparar:campo_comparar; var MM:tmemo);
  Function Entrantes(A:PosicionGrafo; Var  LE:Lista): Errores;
  Function Salientes(A:PosicionGrafo; Var LS: Lista): Errores;
  procedure recorridoAnchura(x1:tipoelemento; comparar:campo_comparar; var MM:tmemo);
  procedure graficar(lugar_grafico:TImage);
  procedure recorrer_graficar(var FileVar: TextFile);

  end;

implementation

procedure grafo.crearvacio;
var i,j:posiciongrafo;
begin
  for i:=Min to Max do
      begin
           vertices[i].Inicializar;
           for j:= min to max do
               MA[i,j].DV:=false;
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

function grafo.buscarVertice(x:tipoelemento; comparar:campo_comparar):posiciongrafo;
var
  i:posiciongrafo;
  Enc:boolean;
begin
  buscarVertice:=Nulo;
  i:=min;
  enc:=false;
  while (i<= nvertices) and (not enc) do
        if x.CompararTE(vertices[i], comparar)=igual then
           begin
                buscarVertice:=i;
                enc:=true;
           end
        else
           inc(i);
end;

function grafo.VerticeAislado(x:tipoelemento;comparar:campo_comparar):Boolean;
var p,i:posiciongrafo;
begin
  VerticeAislado:= True;
  p:=buscarVertice(x, comparar);
  if VerticeValido(p) then
     begin
          for i:= min to max do
              if MA[i,p].dv <> false then
                 VerticeAislado:= false;
          for i:=min to max-1 do
              if MA[p,i].dv <> false then
                 VerticeAislado:= false;
     end
  else
     VerticeAislado:= false;
end;

function grafo.GradoEntVertice(x:tipoelemento; comparar:campo_comparar):integer;
var p,i:posiciongrafo;
begin
   GradoEntVertice:=0;
   p:=buscarVertice(x, comparar);
   if verticeValido(P) then
   for i:=min to max do
       if MA[i,p].dv <> false then
          inc(GradoEntVertice);

end;

function grafo.GradoSalVertice(x:tipoelemento; comparar:campo_comparar):integer;
var p,i:posiciongrafo;
begin
   GradoSalVertice:=0;
   p:=buscarVertice(x, comparar);
   if verticeValido(P) then
   for i:=min to max do
       if MA[p,i].dv <> false then
          inc(GradoSalVertice);

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
           vertices[nvertices].AsignarValores(x);
           agregarVertice:=ok;
      end;
end;

function grafo.recuperarVertice(a:posiciongrafo; var x:tipoelemento):errores;
begin
  recuperarVertice:=Posicioninvalida;
  if verticevalido(a) then
     begin
          x.AsignarValores(vertices[a]);
          recuperarVertice:=Ok;
     end;
end;

function grafo.eliminarVertice(x:tipoelemento; comparar:campo_comparar):errores;
var i, j, a:posiciongrafo;
begin
  if esvacio then
     eliminarVertice:= Vacio
  else
      begin
           a:=buscarVertice(x, comparar);
           if a=nulo then
              eliminarVertice:=posicioninvalida
           else
             begin
                  for i:= min to nvertices do
                      for j:=a to nvertices-1 do
                          MA[i,j].AsignarValores(MA[i,j+1]);
                  for i:=a to nvertices-1 do
                      for j:=1 to nvertices do
                          MA[i,j].AsignarValores(MA[i+1,j]);
                  for i:=a to nvertices-1 do
                      vertices[i].AsignarValores(vertices[i+1]);
                  dec(nvertices);
                  eliminarVertice:=ok;
             end;
      end;

end;

function grafo.agregarArco(x,y:tipoelemento; comparar:campo_comparar):errores;
var i, j: posiciongrafo;
begin
  agregarArco:= posicioninvalida;
  i:= buscarVertice(x, comparar);
  j:= buscarVertice(y, comparar);
  if (i<>nulo) and (j<>nulo) then
     begin
          MA[i,j].DV:= true;
          agregarArco:=ok;
     end;
end;

function grafo.eliminarArco(x,y:tipoelemento; comparar:campo_comparar):errores;
var i,j:posiciongrafo;
begin
  eliminarArco:= posicioninvalida;
  i:= buscarVertice(x, comparar);
  j:= buscarVertice(y, comparar);
  if verticeValido(i) and verticeValido(j) then
     begin
          MA[i,j].DV:=False;
     end;
end;

function grafo.recuperarArco(i,j:posiciongrafo; var x:tipoelemento):errores;
begin
  recuperarArco:=posicioninvalida;
  if not verticeValido(i) and not verticeValido(j) then
     begin
          x.AsignarValores(MA[i,j]);
          recuperarArco:=ok;
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
      recuperarvertice(i,x);
      Writeln(FileVar,'"' + x.DS + '"');
    end;


  l.Crearvacia;
   for i:=MIN to nvertices do
   begin
     p.Crearvacia;
     x.inicializar;
     x.DN:=i;
     x.DS:= vertices[i].DS;
     if (l.Buscar(x, campo2) = nil) then
       begin
         p.Apilar(x);
         while not p.Esvacia() do
           begin
             p.Recuperartope(x);
             p.Desapilar();
             l.Agregar(x);
             salientes(x.DN,ls);
             pl:=ls.inicio;
             while (pl <> nil) do
               begin
                 ls.recuperar(pl,lx);
                 recuperarvertice(lx.DN,lx);
                 Writeln(FileVar,'"' + x.DS + '"->' + '"' + lx.DS + '"' + '[label="vinculo"]');
                 if (l.Buscar(lx, campo2)=nil) then
                    p.Apilar(lx);
                 pl:=ls.siguiente(pl);
               end;
           end;
       end;
   end;

  end;


end.
