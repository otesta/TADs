unit Listaspunteros;

{$mode objfpc}{$H+}

interface

uses


const
  Min=1;
  Max=100;
  Nulo=Nil;

Type
  Posicion_lista = ^Nodo_lista;
  Nodo_lista = Record
    Datos: TipoElemento;
    Ant, Prox: Posicion_lista
  end;

  Lista = object
  Inicio, Final: Posicion_lista;
  q_item: longint;
  procedure Crearvacia;
  function Esvacia(): Boolean;
  function Esllena(): Boolean;
  function Agregar(x: TipoElemento): Errores;
  function Insertar(x: TipoElemento; p: Posicion_lista): Errores;
  function Eliminar(p: Posicion_lista): Errores;
  function Buscar(x: TipoElemento; Comparar: Campo_Comparar): Posicion_lista;
  function Siguiente(p: Posicion_lista): Posicion_lista;
  function Anterior(p: Posicion_lista): Posicion_lista;
  function Recuperar(p: Posicion_lista; var x : TipoElemento): Errores;
  function Actualizar(x: TipoElemento; p: Posicion_lista): Errores;
  function Validar(p: Posicion_lista): Boolean;
  end;

implementation

  procedure Lista.Crearvacia;
  begin
    Inicio:= Nulo;
    Final:= Nulo;
    q_item:= 0;
  end;

  function Lista.Esvacia(): Boolean;
  begin
    Esvacia:= (Inicio=Nulo);
  end;

  function Lista.Esllena(): Boolean;
  begin
    Esllena:=(q_item=Max)
  end;

  function Lista.Agregar(x: TipoElemento): Errores;
  var
    q: Posicion_lista;
  begin
    If Esllena then
       Agregar:= LLeno
    else
        begin
          New(q);
          q^.prox:= Nulo;
          q^.ant:= Final;
          If Esvacia then
             Inicio:= q
          else
              Final^.prox:=q;
          Final:=q;
          q^.Datos.AsignarValores(x);
          Inc(q_item);
          Agregar:= Ok;
        end;
  end;

  function Lista.Insertar(x: TipoElemento; p: Posicion_lista): Errores;
  var
    q: Posicion_Lista;
  begin
    If Esllena then
       Insertar:= LLeno
    else
       If Not Validar(p) then
          Insertar:= PosicionInvalida
       else
           begin
             If Esvacia then
                Insertar:=Agregar(x)
             else
                begin
                  New(q);
                  q^.prox:= p;
                  q^.ant:= p^.ant;
                  if p=Inicio then
                     Inicio:= q
                  else
                      p^.ant^.prox:=q;
                  p^.ant:=q;
                  q^.Datos.AsignarValores(x);
                  Inc(q_item);
                  Insertar:= Ok;
                end;
           end;
  end;

  function Lista.Eliminar(p: Posicion_lista): Errores;
  begin
    If Esvacia then
       Eliminar:= Vacio
    else
       If Not Validar(p) then
          Eliminar:= PosicionInvalida
       else
          begin
            If ((Inicio=p) and (p=Final)) then
               Crearvacia
            else
                begin
                  if  (p= Inicio) then
                     begin
                       Inicio:= p^.prox;
                       Inicio^.ant:=Nulo;
                     end
                  else
                      if (p=final) then
                         begin
                           Final:= p^.ant;
                           Final^.prox:= Nulo;
                         end
                      else
                          begin
                            p^.ant^.prox:= p^.prox;
                            p^.prox^.ant:= p^.ant;
                          end;
                  Dec(q_item);
                end;
            Dispose(p);
            Eliminar:= Ok;
          end;
  end;

  function Lista.Buscar(x: TipoElemento; Comparar: Campo_Comparar): Posicion_lista;
  var
    q: Posicion_Lista; Enc: Boolean;
  begin
    Buscar:= Nulo;
    q:= Inicio;
    Enc:= False;
    While (q<>Nulo) and Not (Enc) do
          begin
               If x.CompararTE(q^.Datos, Comparar)= Igual then
                  begin
                       Buscar:=q;
                       Enc:= True;
                  end;
               q:= Siguiente(q);
          end;
  end;

  function Lista.Siguiente(p: Posicion_lista): Posicion_lista;
  begin
       Siguiente:= p^.prox;
  end;

  function Lista.Anterior(p: Posicion_lista): Posicion_lista;
  begin
       Anterior:= p^.ant;
  end;

  function Lista.Recuperar(p: Posicion_lista; var x : TipoElemento): Errores;
  begin
    If Not Validar(p) then
       Recuperar:= PosicionInvalida
    else
       begin
            x.AsignarValores(p^.Datos);
            Recuperar:= Ok;
       end;
  end;

  function Lista.Actualizar(x: TipoElemento; p: Posicion_lista): Errores;
  begin
    If Not Validar(p) then
       Actualizar:= PosicionInvalida
    else
        begin
             p^.Datos.AsignarValores(x);
             Actualizar:=Ok;
        end;
  end;

  function Lista.Validar(p: Posicion_lista): Boolean;
  var
    q: Posicion_Lista;
  begin
    q:= Inicio;
    Validar:= false;
    if (p<> Nulo) then
       begin
          while ((q<> Nulo) and (q<>p)) do
                q:=q^.prox;
          if q=p then
             Validar:= true;
       end;
  end;

end.

