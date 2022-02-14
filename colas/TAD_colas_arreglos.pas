unit Colaarreglos;

{$mode objfpc}{$H+}

interface

uses
  Tipos;

const
  Min=1;
  Max=100;
  Nulo=0;

Type
  Posicion_cola = longint;
  Cola = object
  Elementos: array[Min..Max] of TipoElemento;
  Frente, Final: Posicion_cola;
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

  function Paso (p: Posicion_cola): Posicion_cola;
  begin
    Paso:=(p mod max)+1;
  end;

  procedure Cola.Crearvacia;
  begin
    Frente:= Min;
    Final:= Max;
    q_item:= 0;
  end;

  function Cola.Esvacia(): Boolean;
  begin
    Esvacia:= (Paso(Final)=Frente);
  end;

  function Cola.Esllena(): Boolean;
  begin
    Esllena:=(Paso(Paso(Final))=Frente)
  end;

  function Cola.Encolar(x: TipoElemento): Errores;
  begin
    If Esllena then
       Encolar:= LLeno
    else
        begin
          Final:= Paso(Final);
          Elementos[Final].AsignarValores(x);
          Inc(q_item);
          Encolar:= Ok;
        end;
  end;

  function Cola.Desencolar(): Errores;
  begin
    If Esvacia then
       Desencolar:= Vacio
    else
       begin
          if (Frente=Final) then
             Crearvacia
          else
              begin
                Frente:= Paso(Frente);
                Dec(q_item);
              end;
          Desencolar:= Ok;
       end;
  end;

  function Cola.Recuperarfrente(var x : TipoElemento): Errores;
  begin
    If Esvacia then
       Recuperarfrente:= Vacio
    else
       begin
            x.AsignarValores(Elementos[Frente]);
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

