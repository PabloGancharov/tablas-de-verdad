unit tipos;

interface
Type
    tiposimbologramatical=(

    OPno,OPo,OPy,OPofuerte,Opnegconj,OPcond,OPbicond,
    OPnegalt,ParentesisA,ParentesisC,Variable,No_existe,Pesos,
    bA,M,bB,N,bC,T,bD,U,bE
                            );

Const

     MaxSimb=25;
cadenasimbologramatical:Array [tiposimbologramatical]of string = (
    '-',' O ',' Y ',' O Fuerte ',' Neg Conjunta ',' -> ',' <=> ',
    ' | ','(',')','Variable','No_existe',' FIN',
    'bA','M','bB','N','bC','T','bD','U','bE'
                            );
colorsimbologramatical:Array [tiposimbologramatical]of byte = (
    15,14,14,15,15,15,15,
    15,15,15,7,4,9,
    15,15,15,15,15,15,15,15,15
                            );

Type
    tipocomplex=OPno..Pesos;
    tipovars=bA..bE;

    tiporesultadoscan=(Finarchivo,exito,error);

    registroTS=Record
                     Lexema:string;
                     CompLex:tipocomplex;
               end;

    elemTS=array[1..MaxSimb] of registroTS;

    tipots=record                      {tipo tabla de simbolos}
           elem:elemts;
           cant:integer;
           end;


    tipotv=record                      {tipo tabla de variables}
           elem:array[1..maxsimb] of string;
           valor:array[1..maxsimb] of boolean;
           cant:integer;
           end;


           
implementation

end.

