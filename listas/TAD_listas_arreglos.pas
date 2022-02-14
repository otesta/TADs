unit TAD_listas_arreglos;

interface
uses
TAD_tipos,Controls,StdCtrls;
const
min=1;
max=100;
nulo=0;
type
posicion_lista=longint;
lista= object
        elementos: array [min..max] of tipoElemento;
        inicio, final: posicion_lista;
        q_items:longint;


procedure crearvacia;
function esvacia ():boolean;
function esllena():boolean;
function agregar (x:tipoElemento):errores;
function insertar(x: TipoElemento; p:posicion_lista):errores;
function eliminar(p:posicion_lista):errores;
function siguiente(p:posicion_lista):posicion_lista;
function anterior(p:posicion_lista):posicion_lista;
function recuperar(p:posicion_lista; var x:tipoElemento):errores;
function actualizar(x:tipoElemento; p:posicion_Lista):errores;
function buscar(x:tipoElemento; comparar:campo_comparar):posicion_lista;
function validarposicion (p:posicion_lista):boolean;
procedure imprimir(campo:campo_comparar; memo:Tmemo);
end;


implementation

procedure lista.crearvacia;
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

function lista.validarposicion(p:posicion_lista):boolean;
begin
 validarposicion:= (p >= inicio) and (p <= final);
end;

function lista.siguiente(p:posicion_lista):posicion_lista;
begin
if p=final then
        siguiente:= nulo
else
        siguiente:= p + 1;
end;


function lista.anterior(p:posicion_lista):posicion_lista;
begin
if p=inicio then
        anterior:= nulo
else
        anterior:= p-1;
end;


function lista.insertar(x:TipoElemento;p:posicion_lista):errores;
var
q:posicion_lista;
begin
        if esllena then
                insertar:= LLeno
        else
                if esvacia then
                        insertar:= agregar(x)
                else
                        if (not (validarposicion(p))) then
                                insertar:=posicionInvalida
                        else
                        begin
                        For q:=final downto p do
                                elementos[q+1].asignarvalores(elementos[q]);
                                elementos[p].asignarvalores(x);
                                inc(q_items);
                                inc(final);
                                insertar:=ok;
                        end;
end;


function lista.eliminar(p:posicion_lista):errores;
var
q:posicion_lista;
begin
if esvacia then
        eliminar:= Vacio
else
        if (not (validarposicion(p))) then
                eliminar:=posicionInvalida
        else
        begin
        for q:=p to (final-1) do
                elementos[q].asignarvalores(elementos[q+1]);
                if inicio=final then
                        inicio:=0;
                dec(final);
                dec(q_items);
                eliminar:=ok;
        end;
end;

procedure lista.imprimir (campo:campo_comparar; memo: Tmemo);
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

function lista.agregar (x:tipoElemento): errores;
begin
 if esllena then
        agregar:=LLeno
 else
 begin
        final:=final +1;
        elementos[final].asignarvalores(x);
        if esvacia then
        inicio:=min;
        q_items:= q_items +1;
        agregar:=ok;
 end;
end;

function lista.actualizar(x:tipoelemento; p:posicion_lista):errores;
begin
  if not validarposicion(p) then
   actualizar:=PosicionInvalida
  else
  BEGIN
   elementos[p].asignarvalores(x);
   actualizar:=ok;
   END;
end;

function lista.recuperar (p:posicion_lista; var x:tipoelemento):errores;
begin
 if not validarposicion(p) then
   recuperar:=posicioninvalida
 else
   begin
   x.asignarvalores(elementos[p]);
   recuperar:= ok;
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
 begin
        if x.compararte(elementos[q], comparar) <> igual then
                q:= siguiente (q)
        else
        begin
                encontre:= true;
                buscar:= q;
        end;
 end;
end;




end.
