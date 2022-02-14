unit TAD_pilas_punteros;

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
  procedure graficar(lugar_grafico:TImage);
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

  procedure Pila.graficar(lugar_grafico:TImage);
  var
     UnProceso: TProcess;
     picture1: TPicture;
     i: integer;
     FileVar: TextFile;
     x: tipoelemento;
     P: Pila;
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
      p.Crearvacia;
      i:=1;
      while (not Esvacia()) do
        begin
          Recuperartope(x);
          if (i = 1) then
            Writeln(FileVar,'              <tr><td port="port1" border="1" bgcolor="red">' + x.DS + '</td></tr>')
          else
              Writeln(FileVar,'              <tr><td port="port1" border="1">' + x.DS + '</td></tr>');
          Desapilar();
          p.apilar(x);
          i:=i+1;
        end;
      Writeln(FileVar,'                </table>>');
      Writeln(FileVar,']');
      Writeln(FileVar,'}');
     except
      Writeln('ERROR! IORESULT: ' + IntToStr(IOResult));
     end;
    CloseFile(FileVar);
    while (not p.Esvacia()) do
      begin
        p.Recuperartope(x);
        p.Desapilar();
        apilar(x);
      end;


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

