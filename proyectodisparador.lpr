program ProyectoDisparador;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, FormDisparador, LResources;

{$IFDEF WINDOWS}{$R proyectodisparador.rc}{$ENDIF}

begin
  {$I proyectodisparador.lrs}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

