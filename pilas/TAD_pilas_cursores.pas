unit Pilascursores;

{$mode objfpc}{$H+}

interface

uses
  Tipos;

const
  Min=1;
  Max=100;
  Nulo=0;

Type
  Posicion_pila = longint;
   Nodo_pila = Record
    Datos:TipoElemento;
    Prox:Posicion_pila
  end;

  Pila = object
  Cursor: array[Min..Max] of Nodo_pila;
  Tope, Libre: Posicion_pila;
  q_item: longint;
  procedure Crearvacia;
  function Esvacia(): Boolean;
  function Esllena(): Boolean;
  function Apilar(x: TipoElemento): Errores;
  function Desapilar(): Errores;
  function Recuperartope(var x : TipoElemento): Errores;
  function Intercambiar(var Paux: Pila; Vaciar:Boolean): Errores;
  end;

implementation

  procedure Pila.Crearvacia;
  var
    q: Posicion_pila;
  begin
    For q:= Min to Max-1 do
        Cursor[q].prox:= q+1;
    Cursor[Max].prox:= Nulo;
    Tope:= Nulo;
    Libre:= Min;
    q_item:= 0;
  end;

  function Pila.Esvacia(): Boolean;
  begin
    Esvacia:= (Tope=Nulo);
  end;

  function Pila.Esllena(): Boolean;
  begin
    Esllena:=(Libre=Nulo)
  end;

  function Pila.Apilar(x: TipoElemento): Errores;
  var
    q: Posicion_pila;
  begin
    if Esllena then
       Apilar:=Lleno
    else
        begin
          q:=Libre;
          Libre:= Cursor[Libre].prox;
          Cursor[q].prox:= Tope;
          Tope:=q;
          Cursor[q].Datos.AsignarValores(x);
          Inc(q_item);
          Apilar:=Ok;
        end;
  end;

  function Pila.Desapilar(): Errores;
  var
    q:Posicion_pila;
  begin
    if Esvacia then
       Desapilar:= Vacio
    else
        begin
          q:=Tope;
          Tope:=Cursor[Tope].Prox;
          Cursor[q].Prox:= Libre;
          Libre:= q;
          Dec(q_item);
          Desapilar:=Ok;
        end;
  end;

  function Pila.Recuperartope(var x : TipoElemento): Errores;
  begin
    if Esvacia then
       Recuperartope:= Vacio
    else
        begin
          x.AsignarValores(Cursor[Tope].Datos);
          Recuperartope:= Ok;
        end;
  end;

  function Pila.Intercambiar(var Paux: Pila; Vaciar:Boolean): Errores;
  Var
    x:TipoElemento;
  begin
    if Paux.Esvacia then
       Intercambiar:= Vacio
    else
        begin
          if Vaciar then
             Crearvacia;
          While Not Paux.Esvacia do
                begin
                     Paux.Recuperartope(x);
                     Apilar(x);
                     Paux.Desapilar;
                end;

        end;
  end;

end.

