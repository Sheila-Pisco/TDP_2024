{1. El administrador de un edificio de oficinas tiene la información del pago de las expensas de dichas oficinas. 
Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que administra. 
Se deben cargar, para cada oficina, el código de identificación, DNI del propietario y valor de la expensa. 
La lectura finaliza cuando llega el código de identificación 0.
b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por código de identificación de la oficina. 
Ordenar el vector aplicando uno de los métodos vistos en la cursada.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector generado en b) y un código de identificación de oficina. 
En el caso de encontrarlo, debe retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no se encontró la oficina.
d) Un módulo recursivo que retorne el monto total de las expensas.}

program actividad51;
const 
	df = 300; 
type
	oficina = record
		codigo:integer;
		dniPropietario:string;
		valorExpensa:integer;	
	end;
	
	vectorOficinas = array [1..df] of oficina;
{------------------------------------ INCISO A ------------------------------------}	
procedure leerOficina(var o:oficina);
var dni:array [1..5] of string =('14238880','15637897','17964234','19342512','35407807');
begin
	o.codigo:= random(10)*100;
	if(o.codigo<>0)then begin
		o.dniPropietario:= dni[random(5)+1];
		o.valorExpensa:= random(19)*100;
	end;
end;
procedure cargarOficinas(var v:vectorOficinas;var dl:integer);
var ofi:oficina;
begin
	leerOficina(ofi);
	if(dl<df)and(ofi.codigo<>0)then begin
		dl:=dl + 1;
		v[dl]:= ofi;
		cargarOficinas(v,dl);
	end;
end;
procedure imprimirVectorOficinas(v:vectorOficinas;dl:integer);
var i:integer;
begin
	writeln('---- Oficinas registradas --->');
	for i:=1 to dl do 
		writeln('Codigo: ',v[i].codigo,'  Dni propietario: ',v[i].dniPropietario,'  Valor expensa: ',v[i].valorExpensa);
end;
{------------------------------------ INCISO B ------------------------------------}
procedure ordenarPorCodigo(var v:vectorOficinas; dl:integer);
var i,j:integer; actual:oficina;
begin
	for i:= 2 to dl do begin
		actual:= v[i];
		j:=i-1;
		while(j<>0)and(v[j].codigo > actual.codigo)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:= actual;
	end;
end;
{------------------------------------ INCISO C ------------------------------------}
function busquedaDicotomica(v:vectorOficinas;i,dl:integer;codigo:integer):integer;
var medio:integer;
begin
	if(i <= dl)then begin
		medio:= (dl+i)div 2;
		if(v[medio].codigo = codigo)then
			busquedaDicotomica:= medio
		else if(v[medio].codigo < codigo)then
			busquedaDicotomica:= busquedaDicotomica(v,medio+1,dl,codigo)
		else
			busquedaDicotomica:= busquedaDicotomica(v,i,medio-1,codigo);
	end else
		busquedaDicotomica:=0;
end;
{------------------------------------ INCISO D ------------------------------------}
function retornarMontoTotalExpensas(v:vectorOficinas;dl:integer):real;
begin
	if(dl > 0)then 
		retornarMontoTotalExpensas:= v[dl].valorExpensa + retornarMontoTotalExpensas(v,dl-1)
	else
		retornarMontoTotalExpensas:= 0; 
end;
{-------------------------------- PROGRAMA PRINCIPAL ------------------------------}
var
	vo:vectorOficinas;
	diml:integer;
	ini,cod,pos:integer;

begin
	diml:=0;
	cargarOficinas(vo,diml); imprimirVectorOficinas(vo,diml); writeln;
	
	ordenarPorCodigo(vo,diml);
	writeln('Vector ordenado por codigo:'); imprimirVectorOficinas(vo,diml); writeln;
	ini:=1; 
	write('Ingrese un codigo: ');readln(cod);
	pos:= busquedaDicotomica(vo,ini,diml,cod);
	writeln('Posicion: ',pos);
	if(pos<>0)then writeln('Dni del propietario: ',vo[pos].dniPropietario)
	else writeln('No se encontro el codigo');
	writeln('Monto total de expensas: ',retornarMontoTotalExpensas(vo,diml):1:2);
end.
	
