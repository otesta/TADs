unit TAD_listas_cursores;

interface

uses
  StdCtrls, Controls, TAD_tipos;


const
min=1;
max=100;
nulo=0;

type
  posicion_lista=longint;
  nodo_lista=record
                datos:tipoElemento;
                ante,prox:posicion_lista;
             end;
  lista=object
        cursor:array[min..max] of nodo_lista;
        inicio,final,libre:posicion_lista;
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
procedure imprimir(campo:campo_comparar;memo:tmemo);
end;




implementation

procedure lista.crearvacia();
var
q:integer;
begin
for q:=min to max do
begin
        cursor[q].ante:=q-1;
        cursor[q].prox:=q+1;
end;
cursor[min].ante:=nulo;
cursor[max].prox:=nulo;
inicio:=nulo;
final:=nulo;
q_items:=0;
libre:=min;
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
        q:=libre;
        libre:=cursor[libre].prox;
        cursor[q].prox:=nulo;
        cursor[q].ante:=final;
        if esvacia then
                inicio:=q
        else
                cursor[final].prox:=q;
        final:=q;
        cursor[final].datos.asignarvalores(x);
        agregar:=ok;
end;
end;

function lista.validarposicion(p:posicion_lista):boolean;
var
q:posicion_lista;
begin
q:=inicio;
while (q<>nulo) and (p<>q) do
        q:= cursor[q].prox;
        if (p=q) then
                validarposicion:=true;
end;

function lista.siguiente(p:posicion_lista):posicion_lista;
begin
siguiente:=cursor[p].prox;
end;


function lista.anterior(p:posicion_lista):posicion_lista;
begin
anterior:=cursor[p].ante;
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
                q:=libre;
                libre:=cursor[libre].prox;
                cursor[q].prox:=p;
                cursor[q].ante:=cursor[p].ante;
                if p=inicio then
                inicio:=q
                else
                cursor[cursor[p].ante].prox:=q;
                cursor[p].ante:=q;
                cursor[q].datos.asignarvalores(x);
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
     inicio:=cursor[p].prox;
     cursor[p].ante:=nulo;
    end
 else
  if (p=final) then
   begin
    final:=cursor[p].ante;
    cursor[final].prox:=nulo;
   end
 else
   begin
    cursor[cursor[p].ante].prox:=cursor[p].prox;
    cursor[cursor[p].prox].ante:=cursor[p].ante;
   end;
 dec(q_items);
 cursor[p].prox:=libre;
 libre:=p;
 eliminar:=ok;
  end;
end;

function lista.actualizar(x:tipoelemento; p:posicion_lista):errores;
begin
  if not validarposicion(p) then
   actualizar:=posicioninvalida
  else
   begin
     cursor[p].datos.asignarvalores(x);
     actualizar:=ok;
   end;
end;

function lista.recuperar (p:posicion_lista; var x:tipoelemento):errores;
begin
 if not validarposicion(p) then
   recuperar:=posicioninvalida
 else
   begin
    x.asignarvalores(cursor[p].datos);
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
  if x.compararte(cursor[q].datos,comparar)<>igual then
   q:=siguiente(q)
  else
   begin
     encontre:=true;
     buscar:=q;
   end;
end;

procedure lista.imprimir (campo:campo_comparar; memo: tmemo);
var
q: posicion_lista;
x:tipoElemento;
s1,s,s2: string;
begin
q:=inicio;
        while (q <> nulo) do
        begin
        s:= '';
        recuperar (q,x);
        case campo of
        campo1:
                s:= x.DS;
        campo2:
                str(x.DN, s);
        campo3:
                str(x.DR:2:2,s);
        campo1y2:
                begin
                str(x.DN,s1);
                s:=x.DS + '-' + s1;
                end;
        campo2y3:
                begin
                str(x.DN, s1);
                str(x.DR:2:2, s2);
                s:= s1 + '-' + s2;
                end;
        campo1y3:
                begin
                str(x.DR:2:2, s2);
                s:= x.DS + '-' + s2;
                end;
        campo123:
                begin
                str(x.DN, s1);
                str(x.DR:2:2, s2);
                s:= x.DS + '-' + s1 + '-' + S2;
                end;
        end;
        memo.lines.add(s);
        q:=siguiente(q);
        end;
end;

end.
