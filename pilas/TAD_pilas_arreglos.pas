unit Pilasarreglos;

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
  Pila = object
  Elementos: array[Min..Max] of TipoElemento;
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
    Tope:= Max+1;
    q_item:= 0;
  end;

  function Pila.Esvacia(): Boolean;
  begin
    Esvacia:= (Tope=Max+1);
  end;

  function Pila.Esllena(): Boolean;
  begin
    Esllena:=(Tope=Min)
  end;

  function Pila.Apilar(x: TipoElemento): Errores;
  begin
    if Esllena then
       Apilar:=Lleno
    else
        begin
          Dec(Tope);
          Elementos[Tope].AsignarValores(x);
          Inc(q_item);
          Apilar:=Ok;
        end;
  end;

  function Pila.Desapilar(): Errores;
  begin
    if Esvacia then
       Desapilar:= Vacio
    else
        begin
          Inc(Tope);
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
          x.AsignarValores(Elementos[Tope]);
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

