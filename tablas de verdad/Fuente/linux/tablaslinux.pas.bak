unit tablaslinux;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus, Buttons, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    barrah: TImage;
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    B_Generar: TBitBtn;
    Copiar1: TMenuItem;
    Edicion1: TMenuItem;
    Edit1: TEdit;
    grid_tabla: TStringGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    menu1: TPopupMenu;
    procedure B_GenerarClick(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);

    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Copiar1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation
uses an_tabla,Clipbrd;


{ TForm1 }

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
edit1.SelText  :=(' Y ');
{edit1.Text :=edit1.Text + ' Y ';   }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
edit1.SelText :=(') ');
{edit1.Text := edit1.text + ' -';    }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;


procedure TForm1.BitBtn12Click(Sender: TObject);
begin
  Form1.close;
end;

procedure TForm1.BitBtn13Click(Sender: TObject);
begin
showmessage ('Autor : Pablo Gancharov'
+ chr(10)+chr(13)
+ chr(10)+chr(13)+'Fecha de la primera version: 12:37 04/10/2007'
+ chr(10)+chr(13)
+ chr(10)+chr(13)+ 'PAYSANDU - URUGUAY'
+ chr(10)+chr(13)
+ chr(10)+chr(13)+ 'pablogancharov@gmail.com' );
end;

procedure TForm1.B_GenerarClick(Sender: TObject);

var
tabla:tiponodotitulo;
j:tiponodotitulo;
h:tiponodovalor;

x,y:byte;


begin
tabla:=nil;
grid_tabla.ColCount :=1;
grid_tabla.RowCount :=2;
grid_tabla.cells [0,0]:='';
grid_tabla.FixedRows :=1;




if calcular_tabla(edit1.Text , tabla)= false then
  begin

    MessageDlg('Error en la expresion', mtError, [mbOK],0);

  end
else
  begin


    x:=0;
    y:=0;
    j:=tabla;
      while j<>nil do
        begin

          if (grid_tabla.ColCount <x+1) then grid_tabla.ColCount :=x+1;
          grid_tabla.Cells [ x,y]:= j^.etiqueta;


          h:=j^.p_val;
          while h<>nil do
              begin
                inc(y);
                if (grid_tabla.RowCount <y+1) then grid_tabla.rowCount :=y+1;
                if  h^.valor = true then
                    grid_tabla.Cells [ x,y]:='V'
                else
                    grid_tabla.Cells [ x,y]:='F';

                h:=h^.p_val;
              end;
          y:=0;
          inc(x);
          j:=j^.sigcol;


        end;
  liberar_tabla (tabla);
  end;


end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  edit1.SelText:= (' NEGCONJ ');
{
edit1.Text :=edit1.Text + ' NEGCONJ '; }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  edit1.SelText:= (' BICOND ');
{edit1.Text :=edit1.Text + ' BICOND '; }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  edit1.SelText:= (' O ');
{edit1.Text :=edit1.Text + ' O '; }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  edit1.SelText:= (' OFUERTE ');
{edit1.Text :=edit1.Text + ' OFUERTE '; }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  edit1.SelText:= (' NEGALT ');
{edit1.Text :=edit1.Text + ' NEGALT ';    }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  edit1.SelText:= (' -> ');
{
edit1.Text :=edit1.Text + ' -> ';   }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
edit1.SelText:= (' -');
{edit1.Text := edit1.text + ' -';    }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
edit1.SelText:= (' (');
{edit1.Text := edit1.text + ' -';    }
edit1.SetFocus;
edit1.SelStart :=length(edit1.Text);
edit1.SelLength:=0;
end;

procedure TForm1.Copiar1Click(Sender: TObject);

var
  i, j:Integer;
  Str:String;
begin

  // Inicializamos
  Str := '';

    // Para cada elemento dentro de la línea fija
    for j := 0 to (grid_tabla.ColCount-1 ) do
      begin
           // Si no es la primera celda, añadimos un separados
           if (j <> 0) then begin
              Str := Str + #9;
           end;
           // Construimos la cadena
           Str := Str + grid_tabla.Cells [j,0] ;

      end;
    Str := Str + #13#10;

  // Para cada línea de las selecciondas
  for i := (grid_tabla.Selection.Top) to (grid_tabla.Selection.Bottom) do begin
    // Si no es la 1ª linea, añadimos un salto de línea
    if (i <> grid_tabla.Selection.Top) then begin
      Str := Str + #13#10;
    end;

    // Para cada elemento dentro de la línea (celdas)
    for j := 0 to (grid_tabla.Rows[i].Count - 1) do begin
      // Si no es la primera celda, añadimos un separados
      if (j <> 0) then begin
        Str := Str + #9;
      end;
      // Construimos la cadena
      Str := Str + grid_tabla.Rows[i].Strings[j];
    end;
    // La guardamos en el clipboard (como texto)
    Clipboard.AsText := Str

end;

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key = chr(13) then B_Generar.Click ;
end;

initialization
  {$I tablaslinux.lrs}

end.

