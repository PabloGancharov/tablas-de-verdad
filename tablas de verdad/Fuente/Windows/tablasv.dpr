program tablasv;

uses
  Forms,
  tablas in 'tablas.pas' {Form1},
  an_tabla in 'an_tabla.PAS',
  an_sint in 'an_sint.pas',
  an_lex in 'an_lex.pas',
  Tipos in 'Tipos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Analizador de tablas de Verdad';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
