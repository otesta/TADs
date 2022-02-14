unit TAD_listas_punteros;

interface
uses TAD_tipos,Controls,StdCtrls,Graphics, SysUtils, FileUtil, LResources,
  ExtCtrls, Process ;
const
min=1;
max=100;
nulo=nil;
Type
posicion_lista=^nodo_lista;
nodo_lista=record
                dato:tipoElemento;
                ante,prox:posicion_lista;
           end;

lista=Object
inicio,final:posicion_lista;
q_items:longint;
procedure crearvacia();
function esvacia():boolean;
function esllena():boolean;
function agregar(x:tipoElemento):errores;
function insertar(x:tipoElemento;p:posicion_lista):errores;
function eliminar(p:posicion_lista):errores;
function anterior(p:posicion_lista):posicion_lista;
function siguiente(p:posicion_lista):posicion_lista;
function recuperar(p:posicion_lista;var x:TipoElemento):errores;
function validarposicion(p:posicion_lista):boolean;
function buscar(x:TipoElemento;comparar:campo_comparar):posicion_lista;
function actualizar(x:TipoElemento;p:posicion_lista):errores;
procedure imprimir(campo:campo_comparar;editor:tedit);
procedure graficar(lugar_grafico:TImage);
end;
implementation

procedure lista.crearvacia();
begin
inicio:=nulo;
final:=nulo;
q_items:=0;
end;

function lista.esvacia():boolean;
begin
esvacia:=(inicio=nulo);
end;

function lista.esllena():boolean;
begin
esllena:=(q_items=max);
end;

function lista.agregar(x:tipoElemento):errores;
var
q:posicion_lista;
begin
if esllena then
        agregar:=lleno
else
begin
        inc(q_items);
        new(q);
        q^.prox:=nulo;
        q^.ante:=final;
        if esvacia then
                inicio:=q
        else
                final^.prox:=q;
        final:=q;
        final^.dato.asignarvalores(x);
        agregar:=ok;
end;
end;

function lista.validarposicion(p:posicion_lista):boolean;
var
q:posicion_lista;
begin
q:=inicio;
while (q<>nulo) and (p<>q) do
        q:= q^.prox;
if (p=q) then
  validarposicion:=true
else
  validarposicion:=false;
end;

function lista.siguiente(p:posicion_lista):posicion_lista;
begin
siguiente:=p^.prox;
end;


function lista.anterior(p:posicion_lista):posicion_lista;
begin
anterior:=p^.ante;
end;



function lista.insertar(x:TipoElemento;p:posicion_lista):errores;
var
q:posicion_lista;
begin
if esllena then
insertar:=lleno
else
        if esvacia then
        insertar:=agregar(x)
        else
        if (not(validarposicion(p))) then
        insertar:=posicionInvalida
        else
        begin
                inc(q_items);
                new(q);
                q^.prox:=p;
                q^.ante:=p^.ante;
                if p=inicio then
                inicio:=q
                else
                p^.ante^.prox:=q;
                p^.ante:=q;
                q^.dato.asignarvalores(x);
                insertar:=ok;
        end;
end;

function lista.eliminar(p:posicion_lista):errores;
begin
  if esvacia then
  eliminar:= vacio
else
 begin
   if not validarposicion (p) then
    eliminar:=posicioninvalida
 else
    if(p=inicio) and (p=final) then
     begin
     inicio:=nulo;
     final:=nulo;
     end
 else
   if (p=inicio) then
    begin
     inicio:=p^.prox;
     inicio^.ante:=nulo;
    end
 else
  if (p=final) then
   begin
    final:=p^.ante;
    final^.prox:=nulo;
   end
 else
   begin
    p^.ante^.prox:=p^.prox;
    p^.prox^.ante:=p^.ante;
   end;
 dec(q_items);
 dispose(p);
 eliminar:=ok;
  end;
end;

function lista.actualizar(x:tipoelemento; p:posicion_lista):errores;
begin
  if not validarposicion(p) then
   actualizar:=posicioninvalida
  else
   begin
     p^.dato.asignarvalores(x);
     actualizar:=ok;
   end;
end;

function lista.recuperar (p:posicion_lista; var x:tipoelemento):errores;
begin
 if not validarposicion(p) then
   recuperar:=posicioninvalida
 else
   begin
    x.asignarvalores(p^.dato);
    recuperar:=ok;
    end;
end;

function lista.buscar(x:TipoElemento;comparar:campo_comparar):posicion_lista;
var
q:posicion_lista;
encontre:boolean;
begin
 buscar:=nulo;
 encontre:=false;
 q:=inicio;

 while(q <> nulo)and(not encontre) do
  if x.compararte(q^.dato,comparar)<>igual then
   q:=siguiente(q)
  else
   begin
     encontre:=true;
     buscar:=q;
   end;
end;

procedure lista.imprimir (campo:campo_comparar; editor: tedit);
var
q: posicion_lista;
x:tipoElemento;
s1,s,s2: string;
begin
q:=inicio;
        s:= '';
        while (q <> nulo) do
        begin
        recuperar (q,x);
        case campo of
        campo1:
                s:= s + x.DS;
        campo2:
                begin
                str(x.DN, s1);
                s:= s + s1;
                end;
        campo3:
                begin
                str(x.DR:2:2,s1);
                s:= s + s1;
                end;
        campo1y2:
                begin
                str(x.DN,s1);
                s:=s + x.DS + '-' + s1;
                end;
        campo2y3:
                begin
                str(x.DN, s1);
                str(x.DR:2:2, s2);
                s:= s + s1 + '-' + s2;
                end;
        campo1y3:
                begin
                str(x.DR:2:2, s2);
                s:= s + x.DS + '-' + s2;
                end;
        campo123:
                begin
                str(x.DN, s1);
                str(x.DR:2:2, s2);
                s:= s + x.DS + '-' + s1 + '-' + S2;
                end;
        end;
        s:= s + '=>';
        q:=siguiente(q);
        end;
        s:= s + 'nulo';
        editor.text:= s;
end;


procedure lista.graficar(lugar_grafico:TImage);
var
   UnProceso: TProcess;
   picture1: TPicture;
   i: integer;
   FileVar: TextFile;
   p: posicion_lista;
   si,ant: string;
   links: string;
   x,y: tipoelemento;
begin
   // Genero el archivo para mostrar la lista desde GraphViz
   AssignFile(FileVar, './Test.txt');
   try
    Rewrite(FileVar);  // creating the file
    Writeln(FileVar,'digraph G{');
    Writeln(FileVar,'  rankdir=LR;');
    Writeln(FileVar,'    node [shape=record];');
    p:= inicio;
    i:=1;
    links:='';
    while (p <> nulo) do
      begin
        str(i,si);
        recuperar(p,x);
        Writeln(FileVar,'    node' +  si + ' [ label ="<f0>' + x.DS + ' | <f1>"];');

        if (i > 1) then
          begin
            str((i-1),ant);
            links:=links + '"node' + ant + '":f1 -> "node' + si + '":f0;' + char(13);
          end;
        p:=siguiente(p);
        i:=i+1;
      end;
    str(i,si);
    str((i-1),ant);
    links:=links + '"node' + ant + '":f1 -> "node' + si + '":f0;' + char(13);
    Writeln(FileVar,'    node' + si + '[ label ="<f0>' + 'null' + '"];');
    Writeln(FileVar,links);
    Writeln(FileVar,'}');
   except
    Writeln('ERROR! IORESULT: ' + IntToStr(IOResult));
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

end.
