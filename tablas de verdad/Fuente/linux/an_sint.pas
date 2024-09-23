unit an_sint;

{$MODE Delphi}

interface

     Uses Tipos,an_lex;

     Function analisis_sintactico(var fuente:string;var ts:tipots; var tv:tipotv):boolean;

implementation

  type
    tipopila=^nodopila;
    nodopila=record     {pila del ASDPNR}
             elem:tiposimbologramatical;
             sig:tipopila;
        end;
    tipolista=record     {contenido de cada celda}
              error:boolean;
              elem:array [1..5] of tiposimbologramatical;
              cant:integer;
              end;
    tipoTAS=^identArray;
    identArray=Array [tipovars,tipocomplex] of tipolista;


    procedure inicializar_TAS(Var TAS:tipoTAS);
      var
        k:tipovars;
        t:tipocomplex;
      begin
        NEW(tas);

        for k :=bA to  bE do
        begin
          for t :=OPno to pesos do
          begin

            TAS^[k,t].cant:=0;
            TAS^[k,t].error:=true;

          end;
        end;
      end;

    procedure cargar_TAS(Var TAS:tipoTAS);
      begin
        TAS^[bA,OPno].elem[1]:=bB;
        TAS^[bA,OPno].elem[2]:=M;
        TAS^[bA,OPno].cant   :=2;
        TAS^[bA,OPno].error  :=false;

        TAS^[bA,ParentesisA].elem[1]:=bB;
        TAS^[bA,ParentesisA].elem[2]:=M;
        TAS^[bA,ParentesisA].cant   :=2;
        TAS^[bA,ParentesisA].error  :=false;

        TAS^[bA,Variable].elem[1]:=bB;
        TAS^[bA,Variable].elem[2]:=M;
        TAS^[bA,Variable].cant   :=2;
        TAS^[bA,Variable].error  :=false;

        TAS^[M,OPofuerte].elem[1]:=OPofuerte;
        TAS^[M,OPofuerte].elem[2]:=bB;
        TAS^[M,OPofuerte].elem[3]:=M;
        TAS^[M,OPofuerte].cant   :=3;
        TAS^[M,OPofuerte].error  :=false;

        TAS^[M,OPbicond].elem[1]:=OPbicond;
        TAS^[M,OPbicond].elem[2]:=bB;
        TAS^[M,OPbicond].elem[3]:=M;
        TAS^[M,OPbicond].cant   :=3;
        TAS^[M,OPbicond].error  :=false;

        TAS^[M,ParentesisC].error  :=false;

        TAS^[M,Pesos].error  :=false;

        TAS^[bB,OPno].elem[1]:=bC;
        TAS^[bB,OPno].elem[2]:=N;
        TAS^[bB,OPno].cant   :=2;
        TAS^[bB,OPno].error  :=false;

        TAS^[bB,ParentesisA].elem[1]:=bC;
        TAS^[bB,ParentesisA].elem[2]:=N;
        TAS^[bB,ParentesisA].cant   :=2;
        TAS^[bB,ParentesisA].error  :=false;

        TAS^[bB,Variable].elem[1]:=bC;
        TAS^[bB,Variable].elem[2]:=N;
        TAS^[bB,Variable].cant   :=2;
        TAS^[bB,Variable].error  :=false;

        TAS^[N,OPcond].elem[1]:=OPcond;
        TAS^[N,OPcond].elem[2]:=bC;
        TAS^[N,OPcond].elem[3]:=N;
        TAS^[N,OPcond].cant   :=3;
        TAS^[N,OPcond].error  :=false;

        TAS^[N,ParentesisC].error  :=false;

        TAS^[N,Pesos].error  :=false;

        TAS^[N,OPofuerte].error :=false;

        TAS^[N,OPbicond].error:=false;

        TAS^[bC,OPno].elem[1]:=bD;
        TAS^[bC,OPno].elem[2]:=T;
        TAS^[bC,OPno].cant   :=2;
        TAS^[bC,OPno].error  :=false;

        TAS^[bC,ParentesisA].elem[1]:=bD;
        TAS^[bC,ParentesisA].elem[2]:=T;
        TAS^[bC,ParentesisA].cant   :=2;
        TAS^[bC,ParentesisA].error  :=false;

        TAS^[bC,Variable].elem[1]:=bD;
        TAS^[bC,Variable].elem[2]:=T;
        TAS^[bC,Variable].cant   :=2;
        TAS^[bC,Variable].error  :=false;

        TAS^[T,OPo].elem[1]:=OPo;
        TAS^[T,OPo].elem[2]:=bD;
        TAS^[T,OPo].elem[3]:=T;
        TAS^[T,OPo].cant   :=3;
        TAS^[T,OPo].error  :=false;

        TAS^[T,OPnegalt].elem[1]:=OPnegalt;
        TAS^[T,OPnegalt].elem[2]:=bD;
        TAS^[T,OPnegalt].elem[3]:=T;
        TAS^[T,OPnegalt].cant   :=3;
        TAS^[T,OPnegalt].error  :=false;

        TAS^[T,ParentesisC].error  :=false;

        TAS^[T,Pesos].error  :=false;

        TAS^[T,OPofuerte].error :=false;

        TAS^[T,OPbicond].error:=false;

        TAS^[T,OPcond].error:=false;

        TAS^[bD,OPno].elem[1]:=bE;
        TAS^[bD,OPno].elem[2]:=U;
        TAS^[bD,OPno].cant   :=2;
        TAS^[bD,OPno].error  :=false;

        TAS^[bD,ParentesisA].elem[1]:=bE;
        TAS^[bD,ParentesisA].elem[2]:=U;
        TAS^[bD,ParentesisA].cant   :=2;
        TAS^[bD,ParentesisA].error  :=false;

        TAS^[bD,Variable].elem[1]:=bE;
        TAS^[bD,Variable].elem[2]:=U;
        TAS^[bD,Variable].cant   :=2;
        TAS^[bD,Variable].error  :=false;

        TAS^[U,OPy].elem[1]:=OPy;
        TAS^[U,OPy].elem[2]:=bE;
        TAS^[U,OPy].elem[3]:=U;
        TAS^[U,OPy].cant   :=3;
        TAS^[U,OPy].error  :=false;

        TAS^[U,OPnegconj].elem[1]:=OPnegconj;
        TAS^[U,OPnegconj].elem[2]:=bE;
        TAS^[U,OPnegconj].elem[3]:=U;
        TAS^[U,OPnegconj].cant   :=3;
        TAS^[U,OPnegconj].error  :=false;

        TAS^[U,ParentesisC].error  :=false;

        TAS^[U,Pesos].error  :=false;

        TAS^[U,OPofuerte].error :=false;

        TAS^[U,OPbicond].error:=false;

        TAS^[U,OPcond].error:=false;

        TAS^[U,OPo].error:=false;

        TAS^[U,OPnegalt].error:=false;

        TAS^[bE,OPno].elem[1]:=OPno;
        TAS^[bE,OPno].elem[2]:=bE;
        TAS^[bE,OPno].cant   :=2;
        TAS^[bE,OPno].error  :=false;

        TAS^[bE,ParentesisA].elem[1]:=ParentesisA;
        TAS^[bE,ParentesisA].elem[2]:=bA;
        TAS^[bE,ParentesisA].elem[3]:=ParentesisC;
        TAS^[bE,ParentesisA].cant   :=3;
        TAS^[bE,ParentesisA].error  :=false;

        TAS^[bE,Variable].elem[1]:=Variable;
        TAS^[bE,Variable].cant   :=1;
        TAS^[bE,Variable].error  :=false;

      end;



procedure cargar_TabladeSimbolos(var ts:tipots);  {carga dentro de la tabla de simbolos las palabras reservadas}
  begin

     ts.elem [1].lexema:='O';
     ts.elem [1].complex:=OPO;
     ts.elem [2].lexema:='Y';
     ts.elem [2].complex:=OPY;
     ts.elem [3].lexema:='OFUERTE';
     ts.elem [3].complex:=OpOFUERTE;
     ts.elem [4].lexema:='NEGCONJ';
     ts.elem [4].complex:=OPnegconj;
     ts.elem [5].lexema:='COND';
     ts.elem [5].complex:=OPcond;
     ts.elem [6].lexema:='BICOND';
     ts.elem [6].complex:=OPbicond;
     ts.elem [7].lexema:='SIYSOLOSI';
     ts.elem [7].complex:=OPbicond;
     ts.elem [8].lexema:='NEGALT';
     ts.elem [8].complex:=OPnegalt;
     ts.elem [9].lexema:='<=>';
     ts.elem [9].complex:=OPbicond;
     ts.elem [10].lexema:='->';
     ts.elem [10].complex:=OPcond;
     ts.elem [11].lexema:='+';
     ts.elem [11].complex:=OPo;
     ts.elem [12].lexema:='^';
     ts.elem [12].complex:=OPy;
     ts.elem [13].lexema:='ú';
     ts.elem [13].complex:=OPy;
     ts.elem [14].lexema:='(';
     ts.elem [14].complex:=parentesisa;
     ts.elem [15].lexema:=')';
     ts.elem [15].complex:=parentesisc;
     ts.elem [16].lexema:='-';
     ts.elem [16].complex:=OPno;
     ts.elem [17].lexema:='|';
     ts.elem [17].complex:=OPnegalt;

     ts.cant:=17;
  end;

    Procedure cargar_TabladeVariables(var tv:tipotv);  {carga dentro de la tabla de simbolos las palabras reservadas}
      begin
           tv.cant:=0;
      end;



    Procedure insertarenpila(p:tipopila;elemento:tiposimbologramatical);
      begin
            while p^.sig<> nil do p:=p^.sig;
            p^.sig:=new(tipopila);
            p:=P^.sig;
            p^.elem:=elemento;
            p^.sig:=nil;

      end;

    Procedure desapilar(p:tipopila; var elemento:tiposimbologramatical);
      begin
        if p^.sig=nil then
          begin

          end
        else
          begin
            while p^.sig^.sig<> nil do p:=p^.sig;
            elemento:=p^.sig^.elem;
            dispose(p^.sig);
            P^.sig:=nil;
        end;
      end;

    Function pilavacia(p:tipopila):boolean;
      begin
        if p^.sig=nil then pilavacia:=true
               else pilavacia:=false;
      end;

Function Analisis_sintactico(var fuente:string;var ts:tipots; var tv:tipotv):boolean;
var
    resultado:tiporesultadoscan;

    ERRORSINT:boolean;

    TAS:tipoTAS;         {tabla de analisis sintactico}

    Pila:tipopila;       {pila del analizador sintactico}

    b,i:longint;

    complex:tipocomplex;
    lexema:string;

    elemento:tiposimbologramatical;

begin
  cargar_Tabladesimbolos(ts);
  cargar_Tabladevariables(tv);

  inicializar_Tas(TAS);
  cargar_Tas(TAS);
  errorsint:=false;
  i:=1;

  new(pila);
  pila^.sig:=nil;

  insertarenpila(pila,pesos);         {inserta el sibolo pesos y la primer variable de la tas}
  insertarenpila(pila,bA);

  resultado:=scan(fuente,ts,tv,i,complex,lexema);

  desapilar(pila,elemento);

  While (ERRORSINT=false) and (elemento<>pesos)    do
  begin

    if elemento in [OPno..Variable] then    {si es terminal}
         begin
              if elemento<>complex then
                 ERRORSINT:=true
              else
                  begin
                  resultado:=scan(fuente,ts,tv,i,complex,lexema) ;
                  desapilar(pila,elemento);
                  end;

         end
    else if elemento in [Pesos..be] then  {si es variable}
         begin
              if TAS^[elemento,complex].error=true then
                 ERRORSINT:=true
              else
                  begin
                       for B:=TAS^[elemento,complex].cant downto 1 do
                                      Insertarenpila(pila,TAS^[elemento,complex].elem[B]);
                       desapilar(pila,elemento);
                  end;
         end;
   end;


   analisis_sintactico:=pilavacia(pila);


End;

end.

