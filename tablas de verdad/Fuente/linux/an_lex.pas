unit an_lex;

{$MODE Delphi}

interface

     Uses Tipos;

     Function Scan (var fuente:string; var ts:tipots; var tv:tipotv; var posicion:longint;
              var complex:tipocomplex; var lexema:string):tiporesultadoscan;

implementation

  function instalar_en_TS (var ts:tipots;var tv:tipotv;lex:string):tipocomplex;
  var k:integer;

  begin
     k:=1;
     while (k<=ts.cant) and (ts.elem[k].lexema<>lex)do
     inc(k);
     IF k>ts.cant then
        begin
             inc (ts.cant);
             ts.elem [ts.cant].lexema:=lex;
             ts.elem [ts.cant].complex:=Variable;       {<--solo se agregan IDs}

             inc(tv.cant);

             tv.elem[tv.cant]:=lex;

        end;
     instalar_en_ts:=ts.elem[k].complex;

  end;

  var
    car:char;

  Procedure leer(var fuente:string; i:longint ;var car:char);
    begin
    car:=fuente[i];

    end;

  Function es_var(var fuente:string; var posicion:longint ; var lexema:string):boolean;

    const
      q0=0;
      F=[2];
    Type
      q=0..4;
      sigma=(letra,digito,guion,otro,carfin,operadores);
      tipodelta=Array[q,sigma] of q;

    var
      delta:tipodelta;
      Actual:q;

      car:char;
      aumento:byte;

         function carasigma(car:char):sigma;
         begin
         carasigma:=otro;
         case car of
              'A'..'Z','a'..'z':carasigma:=letra;
         end;
         end;

    begin
      delta [0,letra]:=1;
      delta [0,otro]:=4;
      delta [1,letra]:=1;
      delta [1,otro]:=2;


      delta [1,carfin]:=2;
      delta [0,carfin]:=4;


      actual:=q0;
      lexema:='';
      aumento:=0;

      while not (actual in[2,4] ) do begin
           if length(fuente)<posicion+aumento then
              begin
              actual:=delta[actual,carfin];
              inc(aumento);
              end
           else
               begin
                  leer(fuente,posicion+aumento,car);
                  actual:=delta[actual,carasigma(car)];
                  if not (actual in [2,4]) then lexema:=lexema + car;
                  inc(aumento);

               end;
      end;
      es_var:=FALSE;

      if actual in f then
      begin
          es_var:=true;
          dec(aumento);
          posicion:=posicion+aumento;
      end;

    end;

  Function es_simbolo(var fuente:string; var posicion:longint ; var lexema:string):boolean;

    const
      q0=0;
      F=[2];
    Type
      q=0..4;
      sigma=(simbolo,digito,guion,otro,carfin,operadores);
      tipodelta=Array[q,sigma] of q;

    var
      delta:tipodelta;
      Actual:q;

      car:char;
      aumento:byte;

         function carasigma(car:char):sigma;
          begin
            carasigma:=otro;
              case car of
                '<','>','=':carasigma:=simbolo;
                {'0'..'9':carasigma :=digito;}
                '-':carasigma :=guion;
                '+','ú','(',')','|','^' :carasigma:=operadores;
              end;
          end;

    begin
        delta [0,operadores]:=3;
        delta [0,simbolo]:=1;
        delta [0,guion]:=1;
        delta [0,otro]:=4;
        delta [1,simbolo]:=1;
        delta [1,otro]:=2;
        delta [1,guion]:=2;
        delta [1,operadores]:=2;
        delta [3,guion]:=2;
        delta [3,otro]:=2;
        delta [3,simbolo]:=2;
        delta [3,operadores]:=2;

        delta [1,carfin]:=2;
        delta [0,carfin]:=4;
        delta [3,carfin]:=2;

        actual:=q0;
        lexema:='';
        aumento:=0;

        while not (actual in[2,4] ) do
          begin
            if length(fuente)<posicion+aumento then
                begin
                  actual:=delta[actual,carfin];
                  inc(aumento);
                end
            else
                begin
                  leer(fuente,posicion+aumento,car);
                  actual:=delta[actual,carasigma(car)];
                  if not (actual in [2,4]) then lexema:=lexema + car;
                  inc(aumento);

                end;
          end;
          es_simbolo:=FALSE;

        if actual in f then
        begin
            es_simbolo:=true;
            dec(aumento);
            posicion:=posicion+aumento;
        end;

    end;

  Function Obtener_comp_lex (var ts:tipots;lex:string):tipocomplex;
    var k:integer;

    begin
         k:=1;
         Obtener_comp_lex:=No_existe;
         while (k<ts.cant) and (ts.elem[k].lexema<>lex)do inc(k);

         if ts.elem[k].lexema=lex then
         begin
              Obtener_comp_lex:=ts.elem[k].complex;
         end;

    end;

  Function Scan (var fuente:string; var ts:tipots; var tv:tipotv; var posicion:longint;
              var complex:tipocomplex; var lexema:string):tiporesultadoscan;

  Begin
     car:=#0;

     while  not(length(fuente)<posicion) and (car in [#0..#32]) do
        begin
           leer(fuente,posicion,car);
           inc(posicion);
        end;

     if car in  [#0..#32] then
        begin
          scan:=Finarchivo;
          complex:=pesos;
          lexema:='';
        end
     else
        begin
          dec(posicion);
          Scan:=exito;

          if es_var (fuente, posicion,lexema) then
              complex:=instalar_en_TS(ts,tv,lexema)
          else
              begin
                       es_simbolo(fuente, posicion,lexema) ;
                       complex:=Obtener_comp_lex(ts,lexema);
                       if complex=No_existe then Scan:=error;
              end;

        end;

  end;


end.

