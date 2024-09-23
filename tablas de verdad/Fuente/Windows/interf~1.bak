Program interfaz;

uses crt,an_tabla;

var
tabla:tiponodotitulo;


cadena:string;
estado:boolean;

procedure mostrar_valores;
var
   j:tiponodotitulo;
   h:tiponodovalor;

x,y,yy:byte;

begin
textcolor(white);
x:=wherex;
y:=wherey;
j:=tabla;
while j<>nil do begin

      yy:=y;
      gotoxy(x,yy);
      writeln(j^.etiqueta);
      inc(yy);
      gotoxy(x,yy);
      writeln('ÄÄÄÄÄÄÄÅ');
      h:=j^.p_val;
      while h<>nil do begin
            yy:=yy+1;
            gotoxy(x,yy);
            writeln(h^.valor);
            h:=h^.p_val;
      end;

      x:=x+8;
      j:=j^.sigcol;


end;
end;

begin

{Cambio del modo de pantalla}
  TextMode(C80 + Font8x8);
  clrscr;

  textcolor(12);
  writeln('-------------------------------TABLAS DE VERDAD---------------------------------');

  gotoxy(1,3);
  textcolor(7);
  writeln('Ingrese una expresion logica:');
  textcolor(14);

{Lectura de la cadena}
  readln(cadena);

{procesamiento de la tabla}
  estado:=calcular_tabla(cadena,tabla);

  if estado=true then
  begin
    textcolor(GREEN);
    gotoxy (70,4);
    WRITEln('[  OK  ]');
    mostrar_valores;
    liberar_tabla(tabla);
  end
  ELSE
  begin
    textcolor(RED);
    gotoxy (70,4);
    WRITE('[  NO  ]');
  end;



readkey;
Normvideo;

end.