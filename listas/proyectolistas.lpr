program ProyectoListas;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cmem, cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, FormListas, LResources, TAD_tipos, TAD_listas_punteros;

{$IFDEF WINDOWS}{$R proyectolistas.rc}{$ENDIF}

begin
  {$I proyectolistas.lrs}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

