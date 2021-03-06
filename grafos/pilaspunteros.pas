unit Pilaspunteros;

{$mode objfpc}{$H+}

interface

uses
  TAD_Tipos;

const
  Min=1;
  Max=100;
  Nulo=Nil;

Type
  Posicion_pila = ^Nodo_pila;
  Nodo_pila = Record
    Datos:TipoElemento;
    Prox:Posicion_pila
  end;

  Pila = object
  Tope: Posicion_pila;
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
  begin
    Tope:= Nil;
    q_item:= 0;
  end;

  function Pila.Esvacia(): Boolean;
  begin
    Esvacia:= (Tope=Nulo);
  end;

  function Pila.Esllena(): Boolean;
  begin
    Esllena:=(q_item=Max)
  end;

  function Pila.Apilar(x: TipoElemento): Errores;
  var
    q:Posicion_pila;
  begin
    if Esllena then
       Apilar:=Lleno
    else
        begin
          New(q);
          q^.Prox:=Tope;
          Tope:=q;
          q^.Datos.AsignarValores(x);
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
          Tope:=Tope^.Prox;
          Dispose(q);
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
          x.AsignarValores(Tope^.Datos);
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

