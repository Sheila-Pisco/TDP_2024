//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//1.- Implementar un programa que invoque a los siguientes módulos.
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
program actividad1;
const 
	df = 4; inf = 10; sup = 155;
type 
	vector = array[1..df]of integer;
//a. Un módulo recursivo que retorne un vector de a lo sumo 15 números enteros “random” mayores a 10 y menores a 155 (incluidos ambos). La carga finaliza con el valor 20.
procedure cargarVector(var v:vector;var dl:integer);
var num:integer;
begin
	if(dl<df)then begin
		num:=random(sup-inf+1)+inf;
		if(num<>20)then begin
			dl:=dl+1;
			v[dl]:=num;
			cargarVector(v,dl);
		end;
	end;
end;
//b. Un módulo no recursivo que reciba el vector generado en a) e imprima el contenido del vector.
procedure imprimirVector(v:vector; dl:integer);
var i:integer;
begin
	for i:=1 to dl do 
		write('| ',v[i],' ');
	writeln('|');
end; 
//c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
procedure imprimirVectorRec(v:vector;dl:integer;i:integer);
begin
	if(i<=dl)then begin
		write('| ',v[i],' ');
		imprimirVectorRec(v,dl,i+1);
	end else
		writeln('|');
end;
//d. Un módulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores pares contenidos en el vector.
function sumarPares(v:vector;dl,i:integer):integer;
begin
	if(i<=dl)then begin
		sumarPares:= sumarPares(v,dl,i+1);
		if(v[i] MOD 2 = 0) then
			sumarPares:= v[i]+sumarPares(v,dl,i+1)
	end else
		sumarPares:=0;
end;
//e. Un módulo recursivo que reciba el vector generado en a) y devuelva el máximo valor del vector.
function retornarMaximo(v:vector;dl,i:integer):integer;
var max:integer;
begin
	if(i<=dl)then begin
		max:= retornarMaximo(v,dl,i+1);
		if(v[i] > max)then 
			max:= v[i];
		retornarMaximo:= max;
	end else
		retornarMaximo:=-1; 
end;
//f. Un módulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si dicho valor se encuentra en el vector o falso en caso contrario.
function buscarValor(v:vector;dl,i,valor:integer):boolean;
begin
	if(i<=dl)then begin
		buscarValor:= (v[i]=valor)or buscarValor(v,dl,i+1,valor);
	end else
		buscarValor:= false;
end; 
//g. Un módulo que reciba el vector generado en a) e imprima, para cada número contenido en el vector, sus dígitos en el orden en que aparecen en el número. 
//Debe implementarse un módulo recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 142, se debe imprimir 1 4 2.
procedure imprimirDigitos(n:integer);
begin
	if(n<>0)then begin
		imprimirDigitos(n div 10);
		write(n MOD 10,' ');
	end;
end;
procedure imprimirNumeros(v:vector;dl,i:integer);
begin
	if(i<=dl)then begin
		imprimirDigitos(v[i]); writeln('');
		imprimirNumeros(v,dl,i+1);
	end;
end;

var
	v:vector; dl,i,valor:integer;
begin
	randomize;
	dl:=0; cargarVector(v,dl);
	imprimirVector(v,dl);
	i:=1; 
	imprimirVectorRec(v,dl,i); 
	
	writeln('La suma de los pares es: ',sumarPares(v,dl,i));
	
	writeln('El valor maximo del vector es: ',retornarMaximo(v,dl,i));
	
	writeln('Indrese un valor:');readln(valor);
	writeln('El valor ingresado pertenece al vector: ',buscarValor(v,dl,i,valor));
	
	imprimirNumeros(v,dl,i);
end.
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//2.- Escribir un programa que:
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
program actividad2;
const ini = 10; fin = 20;
type
	lista = ^nodo;
	nodo = record
		dato: integer;
		sig: lista;
	end;
//a. Implemente un módulo recursivo que genere y retorne una lista de números enteros “random” en el rango 100-200. Finalizar con el número 100.
procedure cargarLista(var l:lista);
var nue:lista; n:integer;
begin
	n:=random(fin-ini+1)+ini;
	if(n<>ini)then begin
		new(nue);
		nue^.dato:=n;
		nue^.sig:=l;
		l:=nue;
		cargarLista(l);
	end; 
end;
//b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el mismo orden que están almacenados.
procedure imprimirLista(l:lista);
begin
	if(l<>nil)then begin
		write(l^.dato,' ');
		imprimirLista(l^.sig);
	end;
end;
//c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en orden inverso al que están almacenados.
procedure imprimirOrdenInverso(l:lista);
begin
	if(l<>nil)then begin
		imprimirOrdenInverso(l^.sig);
		write(l^.dato,' ');
	end;
end;
//d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo valor de la lista.
function encontrarMenor(l:lista):integer;
var min:integer;
begin
	if(l<>nil)then begin
		min:= encontrarMenor(l^.sig);
		if(l^.dato<min)then
			min:=l^.dato;
		encontrarMenor:= min;
	end else
		encontrarMenor:=999;
end;
//e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva verdadero si dicho valor se encuentra en la lista o falso en caso contrario
function buscarValor(l:lista;num:integer):boolean;
begin
	if(l<>nil)then begin
		buscarValor:= (l^.dato = num)or buscarValor(l^.sig,num);
	end else
		buscarValor:= false;
end;

var
	l:lista; n:integer;
begin
	l:=nil;
	cargarLista(l);
	imprimirLista(l); writeln('');
	imprimirOrdenInverso(l); writeln('');
	writeln('El menor valor de la lista es: ',encontrarMenor(l));
	write('Valor a buscar: ');readln(n);
	writeln('Esta en la lista: ',buscarValor(l,n));
end.
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//	3.- Implementar un programa que invoque a los siguientes módulos.
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
program actividad3;
const df = 10 ; ini = 300; fin = 1550;
type
	vector = array[1..df] of integer;
//a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300 y menores a 1550 (incluidos ambos).	
procedure cargarVector(var v:vector;i:integer);
begin
	if(i<=df)then begin
		v[i]:=random(fin-ini+1)+ini;
		cargarVector(v,i+1);
	end;
end;
//b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado en la práctica anterior)
procedure ordenarVector(var v:vector);
var i,j,actual:integer;
begin
	for i:=1 to df do begin
		actual:=v[i];
		j:=i-1;
		while(j>0)and(v[j]>actual)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=actual;
	end;
end;
procedure imprimirVectorRec(v:vector;i:integer);
begin
	if(i<=df)then begin
		writeln(v[i]);
		imprimirVectorRec(v,i+1);
	end;
end;
//c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente encabezado: Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
//Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector.}
procedure busquedaDicotomica (v: vector; inf,sup: integer; dato:integer; var pos: integer);
var medio:integer;
begin
	if(inf<=sup)then begin
		medio:= (sup + inf)div 2;
		if(v[medio]=dato)then
			pos:=medio
		else begin
			if(v[medio]>dato)then
				busquedaDicotomica(v,inf,medio-1,dato,pos)
			else
				busquedaDicotomica(v,medio+1,sup,dato,pos);
		end;
	end;
end;

var
	v:vector; i,dato,pos:integer;
begin
	i:=1; 
	cargarVector(v,i); 
	ordenarVector(v);
	imprimirVectorRec(v,i);
	writeln('Ingrese el dato que desea buscar: ');readln(dato);
	pos:=-1;
	busquedaDicotomica(v,i,df,dato,pos);
	writeln('Posicion del dato en el vector: ',pos);
end.
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
{4.- Realizar un programa que lea números decimale y que utilice un módulo recursivo que escriba su equivalente en binario. El programa termina cuando el usuario ingresa el número 0 (cero).
Ayuda: Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2.
¿Cómo obtenemos los dígitos que componen al número? ¿Cómo achicamos el número para la próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
program actividad4;
procedure convertirABinario(num:integer);
begin
	if(num<>0)then begin
		convertirABinario(num DIV 2);
		write(num MOD 2);
	end;
end;
var
	dec:integer;
begin
	writeln('Ingrese un numero decimal (0 para salir): ');readln(dec);
	while(dec<>0)do begin
		writeln('Su representacion en binario es:');
		convertirABinario(dec); writeln('');
		writeln('Ingrese un numero decimal (0 para salir): ');readln(dec);
	end;
end.
