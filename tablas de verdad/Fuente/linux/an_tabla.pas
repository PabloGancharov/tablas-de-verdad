unit  an_tabla;

{$MODE Delphi}

interface
type
    tiponodovalor=^nodovalor;            {la tabla de valores final}
        nodovalor=record                 {se definen esta zona par quesea visible desde el exterior de la unit}
                    valor:boolean;
                    p_val:tiponodovalor;
              end;

    tiponodotitulo=^nodotitulo;
        nodotitulo=record
                    etiqueta:string;
                    sigcol:tiponodotitulo;
                    p_val:tiponodovalor;
              end;


function calcular_tabla(fuente:string;var tabla:tiponodotitulo):boolean;
procedure liberar_tabla(var tabla:tiponodotitulo);

Implementation
uses tipos,an_sint,an_lex;

var
    ts:tipots;            {tabla de simbolos(lexico)}
    tv:tipotv;            {tabla para las varaibles}

    elemento:tiposimbologramatical;



procedure analizar_proposiciones(fuente:string;var tabla:tiponodotitulo);

  type
    tipooperandos=^nodooperandos;
    nodooperandos=record
             sig:tipooperandos;
             valor: boolean;
             elem: string;
             end;
    tipooperadores=^nodooperadores;
    nodooperadores=record
             sig:tipooperadores;
             prioridad: byte;
             elem: tiposimbologramatical;
             end;

   tipolistavalores =record
              v:array[1..256] of boolean;
              cant:byte;
              end;
  var

    operandos:tipooperandos;
    operadores:tipooperadores;

    cad_valores:tipolistavalores;  { valores que tomaran las variables }
    h,j,k:byte;
    nivel:integer;
    i:longint;

    expresion:string;
    resultado:boolean;

    TablaO:array[1..4] of boolean;
    TablaY:array[1..4] of boolean;
    TablaCond:array[1..4] of boolean;
    Tablabicond:array[1..4] of boolean;
    TablaNegconj:array[1..4] of boolean;
    TablaNegalt:array[1..4] of boolean;
    TablaOfuerte:array[1..4] of boolean;

    procedure insertar_tabla(var tabla:tiponodotitulo;cad:string;val:boolean);
          var
             celda:tiponodovalor;
             grilla:tiponodotitulo;
          begin
          if tabla=nil then
          begin
             tabla:=new(tiponodotitulo);
             tabla^.etiqueta:=cad;
             tabla^.sigcol:=nil;
             tabla^.p_val:=new(tiponodovalor);

             celda:=tabla^.p_val;
             celda^.valor:=val;
             celda^.p_val:=nil;
          end
          else
          begin
               grilla:=tabla;
               while (grilla^.etiqueta <> cad) and (grilla^.sigcol<>nil) do
                     begin
                          grilla:=grilla^.sigcol;
                     end;

               if grilla^.etiqueta = cad then
                  begin

                       celda:=grilla^.p_val;
                       while celda^.p_val<>nil do celda:=celda^.p_val;
                       celda^.p_val:=new(tiponodovalor);
                       celda:=celda^.p_val;
                       celda^.valor:=val;
                       celda^.p_val:=nil;
                  end
               else
                   begin
                        grilla^.sigcol:=new(tiponodotitulo);
                        grilla:=grilla^.sigcol;

                        grilla^.etiqueta:=cad;
                        grilla^.sigcol:=nil;
                        grilla^.p_val:=new(tiponodovalor);

                        celda:=grilla^.p_val;
                        celda^.valor:=val;
                        celda^.p_val:=nil;

                   end;
          end;
          end;


    procedure InsertarOperando(o:tipooperandos; elemento:string; valor:boolean);
      begin
            while o^.sig<> nil do o:=o^.sig;
            o^.sig:=new(tipooperandos);
            o:=o^.sig;
            o^.elem:=elemento;
            o^.sig:=nil;
            o^.valor:=valor;

      end;

    Function DesapilarOperando(o:tipooperandos;var elemento:string;var valor:boolean):boolean;
      begin
        if o^.sig=nil then
          begin
               DesapilarOperando:=false;
          end
        else
          begin
            while o^.sig^.sig<> nil do o:=o^.sig;
            elemento:=o^.sig^.elem;
            valor:=o^.sig^.valor;

            dispose(o^.sig);
            o^.sig:=nil;
            DesapilarOperando:=true;
        end;
      end;


    procedure Insertaroperador(o:tipooperadores;elemento:tiposimbologramatical;prioridad:byte);
      begin
            while o^.sig<> nil do o:=o^.sig;
            o^.sig:=new(tipooperadores);
            o:=o^.sig;
            o^.elem:=elemento;
            o^.prioridad:=prioridad;
            o^.sig:=nil;
      end;


    procedure Desapilaroperador(o:tipooperadores;var elemento:tiposimbologramatical;var prioridad:byte);
      begin
        if o^.sig=nil then
          begin

          end
        else
          begin
            while o^.sig^.sig<> nil do o:=o^.sig;
            elemento:=o^.sig^.elem;
            prioridad:=o^.sig^.prioridad;

            dispose(o^.sig);
            o^.sig:=nil;
        end;
      end;

    function vaciaoperador(o:tipooperadores):boolean;
      begin
          if o^.sig=nil then vaciaoperador:=true else vaciaoperador:=false;
      end;
    function vaciaoperando(o:tipooperandos):boolean;
      begin
          if o^.sig=nil  then vaciaoperando:=true else vaciaoperando:=false;
      end;

    function prioridadoperador(o:tipooperadores):byte;
      begin
          while o^.sig<> nil do o:=o^.sig;
          Prioridadoperador:=o^.prioridad;
      end;


 Procedure cargarTABLAS;
    begin
    TablaY[1]:=TRUE;
    TablaY[2]:=FALSE;
    TablaY[3]:=FALSE;
    TablaY[4]:=FALSE;

    TablaO[1]:=TRUE;
    TablaO[2]:=TRUE;
    TablaO[3]:=TRUE;
    TablaO[4]:=FALSE;

    TablaCOND[1]:=TRUE;
    TablaCOND[2]:=FALSE;
    TablaCOND[3]:=TRUE;
    TablaCOND[4]:=TRUE;

    TablaBICOND[1]:=TRUE;
    TablaBICOND[2]:=FALSE;
    TablaBICOND[3]:=FALSE;
    TablaBICOND[4]:=TRUE;

    TablaOFUERTE[1]:=FALSE;
    TablaOFUERTE[2]:=TRUE;
    TablaOFUERTE[3]:=TRUE;
    TablaOFUERTE[4]:=FALSE;

    TablaNEGCONJ[1]:=FALSE;
    TablaNEGCONJ[2]:=FALSE;
    TablaNEGCONJ[3]:=FALSE;
    TablaNEGCONJ[4]:=TRUE;

    TablaNEGALT[1]:=FALSE;
    TablaNEGALT[2]:=TRUE;
    TablaNEGALT[3]:=TRUE;
    TablaNEGALT[4]:=TRUE;

  end;
  procedure generar_valores(var cad_valores:tipolistavalores);
    var
      i:byte;
      acarreo:boolean;
  begin
    i:=cad_valores.cant ;
    acarreo:=true;

    repeat
      if cad_valores.v [i]=true  then
        begin
          cad_valores.v[i]:=false;
          acarreo:=false;
        end
      else
      if cad_valores.v[i]=false then
        begin
          cad_valores.v[i]:=true;
          acarreo:=true;
        end
      else acarreo:=false;     {si encuentra otro caracter no hace nada}

      dec(i);
    until acarreo =false;

  end;

  Function pasar_indice(var a,b:boolean):byte;
    begin
      If (a=true) and (b=true) then pasar_indice:=1;
      If (a=true) and (b=false) then pasar_indice:=2;
      If (a=false) and (b=true) then pasar_indice:=3;
      If (a=false) and (b=false) then pasar_indice:=4;
    end;

  function calcula (var a,b:boolean; OP:tipocomplex):boolean;
    begin
      case OP of
        OPo:            calcula:=tablaO[pasar_indice(a,b)];
        OPy:            calcula:=tablaY[pasar_indice(a,b)];
        OPcond:         calcula:=tablacond[pasar_indice(a,b)];
        Opbicond:       calcula:=tablabicond[pasar_indice(a,b)];
        OPnegconj:      calcula:=tablanegconj[pasar_indice(a,b)];
        OPnegalt:       calcula:=tablanegalt[pasar_indice(a,b)];
        OPofuerte:      calcula:=tablaOfuerte[pasar_indice(a,b)];
      end;
    end;

  procedure procesar(var expresion:string; var resultado:boolean);
    var
       t_operador:tiposimbologramatical;
       t_operando1,t_operando2:string;
       t_v1,t_v2:boolean;
       t_pr:byte;
    begin

      desapilaroperador(operadores,t_operador,t_pr);

      if t_operador=OPno then   {la negacion no altera el tope , solo el valor del elemento}
        begin
             desapilaroperando(operandos,t_operando2,t_v2);
             expresion:=cadenasimbologramatical[t_operador]+t_operando2;
             if t_v2=true then t_v2:=false else t_v2:=true;
             insertaroperando(operandos,cadenasimbologramatical[t_operador]+t_operando2,t_v2);

             resultado:=t_v2;


        end
      else
        begin
             desapilaroperando(operandos,t_operando2,t_v2);
             desapilaroperando(operandos,t_operando1,t_v1);

             expresion:=t_operando1+ cadenasimbologramatical[t_operador]+ t_operando2;

             t_v1:=calcula(t_v1,t_v2,t_operador);
             insertaroperando(operandos,'('+t_operando1+cadenasimbologramatical[t_operador]+t_operando2+')',t_v1);

             resultado:=t_v1;

        end;

    end;



  function asignarvalor(operando:string; var tv:tipotv):boolean;
    var k:integer;
    begin
       k:=1;
       while (k<=tv.cant) and
             (operando<>tv.elem[k]) do
             inc(k);

             asignarvalor:=tv.valor[k];
    end;

var

    res:tiporesultadoscan;
    complex:tipocomplex;
    lexema:string;

begin
  cargarTABLAS;

  {Inicializa la variable que contiene los valores de los operandos}
  For j:=1 to tv.cant do cad_valores.v[j]:=true;
  cad_valores.cant :=tv.cant;
  {calcula la cantidad de valores que se necesitaran}
  j:=1;
  for h:=1 to cad_valores.cant  do j:=j*2;

  for h:=1 to j  do
    begin

      new(operadores);
      new(operandos);
      operadores^.sig:=nil;
      operandos^.sig:=nil;
      i:=1;

      {asigna los valores a cada variable}
      for k:=1 to tv.cant do
          begin
               tv.valor[k]:=cad_valores.v[k];
               insertar_tabla(tabla,tv.elem[k],tv.valor[k]);
          end;


      nivel:=0;
      repeat


        res:=scan(fuente,ts,tv,i,complex,lexema);

        case complex of

          variable:     begin
                             insertaroperando(operandos,lexema,asignarvalor(lexema,tv));
                        end;
          parentesisA:nivel:=nivel+5;
          parentesisC:nivel:=nivel-5;
          OPno:         begin
                           while (vaciaOperador(operadores)=false) and (prioridadoperador(operadores)>5+nivel) do
                              begin
                                   procesar(expresion,resultado);
                                   insertar_tabla(tabla,expresion,resultado);
                              end;

                           insertaroperador(operadores,complex ,5+nivel);
                        end;

          OPo:            begin
                           while (vaciaOperador(operadores)=false) and (prioridadoperador(operadores)>3+nivel) do
                              begin
                                   procesar(expresion,resultado);
                                   insertar_tabla(tabla,expresion,resultado);
                              end;
                           insertaroperador(operadores,complex,3+nivel);

                        end;
          OPy:            begin
                           while (vaciaOperador(operadores)=false) and (prioridadoperador(operadores)>4+nivel) do
                              begin
                                   procesar(expresion,resultado);
                                   insertar_tabla(tabla ,expresion,resultado);
                              end;
                           insertaroperador(operadores,complex,4+nivel);

                        end;
          OPcond:         begin
                           while (vaciaOperador(operadores)=false) and (prioridadoperador(operadores)>2+nivel) do
                              begin
                                   procesar(expresion,resultado);
                                   insertar_tabla(tabla,expresion,resultado);
                              end;
                          insertaroperador(operadores,complex,2+nivel);

                        end;
          Opbicond:       begin
                           while (vaciaOperador(operadores)=false) and (prioridadoperador(operadores)>1+nivel) do
                              begin
                                   procesar(expresion,resultado);
                                   insertar_tabla(tabla ,expresion,resultado);
                              end;
                          insertaroperador(operadores,complex,1+nivel);

                        end;
          OPnegconj:      begin
                           while (vaciaOperador(operadores)=false) and (prioridadoperador(operadores)>4+nivel) do
                              begin
                                   procesar(expresion,resultado);
                                   insertar_tabla(tabla,expresion,resultado);
                              end;
                           insertaroperador(operadores,complex,4+nivel);

                        end;
          OPnegalt:       begin
                           while (vaciaOperador(operadores)=false) and (prioridadoperador(operadores)>3+nivel) do
                              begin
                                   procesar(expresion,resultado);
                                   insertar_tabla(tabla,expresion, resultado);
                              end;
                           insertaroperador(operadores,complex,3+nivel);

                        end;
          OPofuerte:      begin
                           while (vaciaOperador(operadores)=false) and (prioridadoperador(operadores)>1+nivel) do
                              begin
                                   procesar(expresion,resultado);
                                   insertar_tabla(tabla,expresion,resultado);
                              end;
                           insertaroperador(operadores,complex,1+nivel);

                        end;

          Pesos:          begin
                                while (vaciaoperador(operadores)=false) do
                                     begin
                                        procesar(expresion,resultado);
                                        insertar_tabla(tabla,expresion,resultado);
                                     end;


                          end;

        end;

     until res=finarchivo;
  generar_valores(cad_valores);
  end;

end;

function calcular_tabla(fuente:string;var tabla:tiponodotitulo):boolean;
var
    estado:boolean;

begin

  {Analisis Sintactico}
  estado:=analisis_sintactico(fuente,ts,tv);

  if estado=true then
        begin
                {Calculo de la tabla de verdad}
                Analizar_proposiciones(fuente,tabla);
                estado:=true;
        end
  ELSE
        begin
             estado:=false;
        end;
  calcular_tabla:=estado;

end;
procedure liberar_tabla(var tabla:tiponodotitulo);
var
      j,jj:tiponodotitulo;
      h,hh:tiponodovalor;
begin

      j:=tabla;
      while j<>nil do
          begin
                h:=j^.p_val;
                while h<>nil do
                begin
                        hh:=h;
                        h:=h^.p_val;
                        dispose (hh);
                end;
                jj:=j;
                j:=j^.sigcol;
                dispose(jj);

          end;


end;

begin

end.

