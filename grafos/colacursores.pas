unit Colacursores;

{$mode objfpc}{$H+}

interface

uses
  TAD_Tipos;

const
  Min=1;
  Max=100;
  Nulo=0;

Type
  Posicion_cola = longint;
  Nodo_Cola = Record
    Datos: TipoElemento;
    Prox: Posicion_cola;
  end;

  Cola = object
  Cursor: array[Min..Max] of Nodo_Cola;
  Frente, Final, Libre: Posicion_cola;
  q_item: longint;
  procedure Crearvacia;
  function Esvacia(): Boolean;
  function Esllena(): Boolean;
  function Encolar(x: TipoElemento): Errores;
  function Desencolar(): Errores;
  function Recuperarfrente(var x : TipoElemento): Errores;
  function Intercambiar(var Caux: Cola; Vaciar: Boolean): Errores;
  end;

implementation

  procedure Cola.Crearvacia;
  var
    q: Posicion_cola;
  begin
    for q:= Min to Max-1 do
        Cursor[q].prox:= q+1;
    Cursor[Max].prox:= 0;
    Frente:= Nulo;
    Final:= Nulo;
    q_item:= 0;
    Libre:= Min
  end;

  function Cola.Esvacia(): Boolean;
  begin
    Esvacia:= (Frente=Nulo);
  end;

  function Cola.Esllena(): Boolean;
  begin
    Esllena:=(Libre=Nulo)
  end;

  function Cola.Encolar(x: TipoElemento): Errores;
  var
    q: Posicion_cola;
  begin
    If Esllena then
       Encolar:= LLeno
    else
        begin
           q:= Libre;
           Libre:= Cursor[Libre].prox;
           Cursor[q].prox:=Nulo;
           if Esvacia then
              Frente:=q
           else
               Cursor[Final].Prox:=q;
           Final:=q;
           Cursor[Final].Datos.AsignarValores(x);
           Inc(q_item);
           Encolar:= Ok;
        end;
  end;

  function Cola.Desencolar(): Errores;
  var
    q: Posicion_cola;
  begin
    q:= Frente;
    If Esvacia then
       Desencolar:= Vacio
    else
       begin
          if (Frente=Final) then
             Crearvacia
          else
              begin
                Frente:= Cursor[Frente].prox;
                Dec(q_item);
              end;
          Cursor[q].Prox:=Libre;
          Libre:=q;
          Desencolar:= Ok;
       end;
  end;

  function Cola.Recuperarfrente(var x : TipoElemento): Errores;
  begin
    If Esvacia then
       Recuperarfrente:= Vacio
    else
       begin
            x.AsignarValores(Cursor[Frente].Datos);
            Recuperarfrente:= Ok;
       end;
  end;

  function Cola.Intercambiar(var Caux: Cola; Vaciar: Boolean): Errores;
  Var
    x: TipoElemento;
  begin
    if Caux.Esvacia then
       Intercambiar:= Vacio
    else
       begin
          if Vaciar then
             Crearvacia;
          While not Caux.Esvacia do
              begin
                Caux.Recuperarfrente(x);
                Encolar(x);
                Caux.Desencolar;
              end;
       end;
  end;

end.

