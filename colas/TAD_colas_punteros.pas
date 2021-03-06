unit TAD_colas_punteros;

{$mode objfpc}{$H+}

interface

uses
  TAD_tipos,Controls,StdCtrls,Graphics, SysUtils, FileUtil, LResources,
  ExtCtrls, Process ;

const
  Min=1;
  Max=100;
  Nulo=Nil;

Type
  Posicion_cola = ^Nodo_Cola;
  Nodo_Cola = Record
    Datos: TipoElemento;
    Prox: Posicion_cola;
  end;

  Cola = object
  Frente, Final: Posicion_cola;
  q_item: longint;
  procedure Crearvacia;
  function Esvacia(): Boolean;
  function Esllena(): Boolean;
  function Encolar(x: TipoElemento): Errores;
  function Desencolar(): Errores;
  function Recuperarfrente(var x : TipoElemento): Errores;
  function Intercambiar(var Caux: Cola; Vaciar: Boolean): Errores;
  procedure graficar(lugar_grafico:TImage);
  end;

implementation

  procedure Cola.Crearvacia;
  begin
    Frente:= Nulo;
    Final:= Nulo;
    q_item:= 0;
  end;

  function Cola.Esvacia(): Boolean;
  begin
    Esvacia:= (Frente=Nulo);
  end;

  function Cola.Esllena(): Boolean;
  begin
    Esllena:=(q_item=Max)
  end;

  function Cola.Encolar(x: TipoElemento): Errores;
  var
    q: Posicion_cola;
  begin
    If Esllena then
       Encolar:= LLeno
    else
        begin
           New(q);
           q^.prox:=Nulo;
           if Esvacia then
              Frente:=q
           else
               Final^.Prox:=q;
           Final:=q;
           Final^.Datos.AsignarValores(x);
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
                Frente:= Frente^.prox;
                Dec(q_item);
              end;
          Dispose(q);
          Desencolar:= Ok;
       end;
  end;

  function Cola.Recuperarfrente(var x : TipoElemento): Errores;
  begin
    If Esvacia then
       Recuperarfrente:= Vacio
    else
       begin
            x.AsignarValores(Frente^.Datos);
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
  procedure Cola.graficar(lugar_grafico:TImage);
  var
     UnProceso: TProcess;
     picture1: TPicture;
     i: integer;
     FileVar: TextFile;
     x: tipoelemento;
     C: Cola;
  begin
     // Genero el archivo para mostrar la lista desde GraphViz
     AssignFile(FileVar, './Test.txt');
     try
      Rewrite(FileVar);  // creating the file
      Writeln(FileVar,'digraph G{');
      Writeln(FileVar,'  rankdir=LR;');
      Writeln(FileVar,'  node1');
      Writeln(FileVar,'[');
      Writeln(FileVar,'  shape=none');
      Writeln(FileVar,'label = <<table border="0" cellspacing="0">');
      C.Crearvacia;
      i:=1;
      while (not Esvacia()) do
        begin
          Recuperarfrente(x);
          if (i = 1) then
            Writeln(FileVar,'              <tr><td port="port1" border="1" bgcolor="red">' + x.DS + '</td></tr>')
          else
              Writeln(FileVar,'              <tr><td port="port1" border="1">' + x.DS + '</td></tr>');
          Desencolar();
          C.Encolar(x);
          i:=i+1;
        end;
      Writeln(FileVar,'                </table>>');
      Writeln(FileVar,']');
      Writeln(FileVar,'}');
     except
      Writeln('ERROR! IORESULT: ' + IntToStr(IOResult));
     end;
    CloseFile(FileVar);
    while (not C.Esvacia()) do
      begin
        c.Recuperarfrente(x);
        c.desencolar();
        encolar(x);
      end;


     // Ahora creamos UnProceso.
     UnProceso := TProcess.Create(nil);

     // Asignamos a UnProceso la orden que debe ejecutar.
     UnProceso.CommandLine := 'dot -Tpng ./Test.txt -o ./lista.png';
     UnProceso.Options := UnProceso.Options + [poWaitOnExit, poUsePipes];

     // Lanzamos la ejecuci??n ...
     UnProceso.Execute;

     // Nuestro programa se detiene hasta que 'ppc386' finaliza.
     UnProceso.Free;

     // Muestro el resultado del graphviz
     picture1 := TPicture.Create;
     picture1.LoadFromFile('./lista.png');
     lugar_grafico.Picture.Assign(picture1);
  end;

end.

