program tablasv;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms ,
//  { add your units here }, tablaslinux, tipos in Tipos.pas, an_tabla;
  tablaslinux in 'tablaslinux.pas' {Form1},
  an_tabla in 'an_tabla.PAS',
  an_sint in 'an_sint.pas',
  an_lex in 'an_lex.pas',
  Tipos in 'Tipos.pas';


//{$R tablasv.res}

begin
  Application.Title:='Tablas de verdad';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

