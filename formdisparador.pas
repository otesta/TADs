unit FormDisparador;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Process, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  UnProceso: TProcess;

implementation

{ TForm1 }

procedure TForm1.Button7Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   // Ahora creamos UnProceso.
   UnProceso := TProcess.Create(nil);

   // Asignamos a UnProceso la orden que debe ejecutar.
   // Vamos a lanzar el compilador de FreePascal
   UnProceso.Executable:= './listas/proyectolistas';
   //UnProceso.CommandLine := './listas/proyectolistas';

   // Lanzamos la ejecución de 'ppc386 -h'.
   UnProceso.Execute;

   // Nuestro programa se detiene hasta que 'ppc386' finaliza.
   UnProceso.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   picture1: TPicture;
   i: integer;
   FileVar: TextFile;
begin
   // Ahora creamos UnProceso.
   UnProceso := TProcess.Create(nil);

   // Asignamos a UnProceso la orden que debe ejecutar.
   UnProceso.Executable:= 'dot -Tpng ./prueba_dot.dot -o ./ejemplo.png';
   //UnProceso.CommandLine := 'dot -Tpng ./prueba_dot.dot -o ./ejemplo.png';

   // Lanzamos la ejecución ...
   UnProceso.Execute;

   // Nuestro programa se detiene hasta que 'ppc386' finaliza.
   UnProceso.Free;

   AssignFile(FileVar, './Test.txt');
   try
    Rewrite(FileVar);  // creating the file
    for i:=1 to 10 do
      Writeln(FileVar,'Hello');
   except
    Writeln('ERROR! IORESULT: ' + IntToStr(IOResult));
   end;
  CloseFile(FileVar);

   // Muestro el resultado del graphviz
   picture1 := TPicture.Create;
   picture1.LoadFromFile('./ejemplo.png');
   Image1.Picture.Assign(picture1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

initialization
  {$I formdisparador.lrs}

end.

