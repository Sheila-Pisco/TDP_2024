{4. Una biblioteca nos ha encargado procesar la información de los préstamos realizados durante el año 2021. 
De cada préstamo se conoce el ISBN del libro, el número de socio, día y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de los préstamos. La lectura de los préstamos finaliza con ISBN 0. 
Las estructuras deben ser eficientes para buscar por ISBN.
	i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos insertarlos a la derecha.
	ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN. (prestar atención sobre los datos que se almacenan).
	
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más grande.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).

c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más pequeño.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos)} 

program ejercicio4Parte2Arboles;
type
	prestamo = record
		ISBN:integer;
		numSocio: integer;
		dia:integer;
		mes:integer;
		diasPrestado:integer;
	end;
{------------> arbol1}	
	arbol1 = ^nodo1;
	nodo1 = record
		dato:prestamo;
		hi:arbol1;
		hd:arbol1;
	end;
{-------------> arbol2}
	datosPrestamo = record
		numSocio: integer;
		dia:integer;
		mes:integer;
		diasPrestado:integer;
	end;
	lista = ^nodoLista;
	nodoLista = record
		dato: datosPrestamo;
		sig:lista;
	end; 
	arbol2 = ^nodo2;
	nodo2 = record
		ISBN:integer;
		prestamos:lista;
		hi:arbol2;
		hd:arbol2;
	end;	
{-------------> lista generada a partir del arbol 1 = lista generada a partir del arbol 2}
	datoISBN = record
		ISBN:integer;
		cant:integer;
	end;
	lista2 = ^nodoLista2;
	nodoLista2 = record
		dato: datoISBN;
		sig: lista2;
	end;
{----------------------------------------------------------------------}
procedure cargarArboles(var a1:arbol1;var a2:arbol2);
	
	procedure cargarPrestamo(var p:prestamo);
	begin
		p.ISBN:= random(10);
		if(p.ISBN <> 0)then begin
			p.numSocio:=random(19)+1;
			p.dia:=random(31)+1;
			p.mes:=random(12)+1;
			p.diasPrestado:=random(15)+1;
		end;
	end;
	procedure cargarArbol1(var a:arbol1;p:prestamo);
	begin
		if(a = nil)then begin
			new(a);
			a^.dato:= p;
			a^.hi:= nil;
			a^.hd:= nil;
		end else begin
			if(p.ISBN < a^.dato.ISBN)then cargarArbol1(a^.hi,p)
			else cargarArbol1(a^.hd,p);
		end;
	end;
	procedure cargarArbol2(var a:arbol2;p:prestamo);
		
		procedure cargarDatosPrestamo(var dp:datosPrestamo;p:prestamo);
		begin
			dp.numSocio:=p.numSocio;
			dp.dia:= p.dia;
			dp.mes:= p.mes;
			dp.diasPrestado:= p.diasPrestado;
		end;
		procedure agregarAdelante(var l:lista; dp:datosPrestamo);
		var nue:lista;
		begin
			new(nue);
			nue^.dato:= dp;
			nue^.sig:= l;
			l:= nue;
		end;
		
	var dp:datosPrestamo; 
	begin
		if(a = nil)then begin
			new(a);
			a^.ISBN:= p.ISBN;
			a^.prestamos:= nil;
			a^.hi:= nil;
			a^.hd:= nil;
			cargarDatosPrestamo(dp,p);
			agregarAdelante(a^.prestamos,dp);
		end else begin
			if(p.ISBN = a^.ISBN)then begin
				cargarDatosPrestamo(dp,p);
				agregarAdelante(a^.prestamos,dp);
			end else 
				if(p.ISBN < a^.ISBN)then cargarArbol2(a^.hi,p)
				else cargarArbol2(a^.hd,p);
		end;
	end;
	
var p:prestamo;
begin
	cargarPrestamo(p);
	while(p.ISBN <> 0)do begin
		cargarArbol1(a1,p);
		cargarArbol2(a2,p);
		cargarPrestamo(p);
	end;
end;
{----------------------------------------------------------------------}
procedure imprimirA1(a:arbol1);
begin
	if(a<>nil)then begin
		imprimirA1(a^.hi);
		writeln('ISBN del libro: ',a^.dato.ISBN,'  Numero de socio: ',a^.dato.numSocio,'  Fecha: ',a^.dato.dia,'/',a^.dato.mes,'  Dias prestado: ',a^.dato.diasPrestado);
		imprimirA1(a^.hd);
	end;
end;
procedure imprimirPrestamos(l:lista);
begin
	if(l<>nil)then begin
		writeln('Fecha: ',l^.dato.dia,'/',l^.dato.mes,'  Numero de socio: ',l^.dato.numSocio,'  Dias prestado: ',l^.dato.diasPrestado);
		imprimirPrestamos(l^.sig);
	end;
end;	
procedure imprimirA2(a:arbol2);
begin
	if(a<>nil)then begin
		imprimirA2(a^.hi);
		writeln('------> ISBN del libro: ',a^.ISBN);
		writeln('Lista de prestamos: ');
		imprimirPrestamos(a^.prestamos);
		writeln;
		imprimirA2(a^.hd);
	end;
end;
{----------------------------------------------------------------------}
{////////////////////////Procesos para el arbol 1//////////////////////}
{----------------------------------------------------------------------}{b.Recibe la estructura generada en i. y retorna el ISBN más grande}
function retornarMaxISBN(a:arbol1):integer;
begin
	if(a<>nil)then begin
		if(a^.hd <> nil)then retornarMaxISBN:=retornarMaxISBN(a^.hd)
		else retornarMaxISBN:=a^.dato.ISBN;
	end else retornarMaxISBN:= -1;
end;
{----------------------------------------------------------------------}{d.Recibe la estructura generada en i. un número de socio y retorna la cantidad de préstamos realizados a dicho socio}
function contarPrestamos(a:arbol1;nro:integer):integer;
begin
	if(a<>nil)then begin
		if(a^.dato.numSocio = nro)then contarPrestamos:= 1 + contarPrestamos(a^.hi,nro) + contarPrestamos(a^.hd,nro)
		else contarPrestamos:= contarPrestamos(a^.hi,nro) + contarPrestamos(a^.hd,nro);
	end else contarPrestamos:= 0;	
end;
{----------------------------------------------------------------------}{f.Recibe la estructura generada en i. y retorna una nueva estructura ordenada por ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó}
procedure agregarAtras(var pri:lista2;var ult:lista2;isbn:integer);
var nue:lista2;
begin
	if(ult<>nil)and(ult^.dato.ISBN = isbn)then 
		ult^.dato.cant:= ult^.dato.cant + 1
	else begin
		new(nue);
		nue^.dato.ISBN:= isbn;
		nue^.dato.cant:= 1;
		nue^.sig:= nil;
		if(pri = nil)then begin
			pri:= nue;
			ult:= nue;
		end else begin
			ult^.sig:= nue;
			ult:= nue;
		end;
	end;	
end;
procedure generarListaPorISBN(a:arbol1;var pri:lista2;var ult:lista2);
begin
	if(a<>nil)then begin
		generarListaPorISBN(a^.hi,pri,ult);
		agregarAtras(pri,ult,a^.dato.ISBN);
		generarListaPorISBN(a^.hd,pri,ult);
	end;
end;	
procedure imprimirLista2(l:lista2);
begin
	if(l<>nil)then begin
		writeln('ISBN: ',l^.dato.ISBN,' Cantidad de prestamos: ',l^.dato.cant);
		imprimirLista2(l^.sig);
	end;
end;
{----------------------------------------------------------------------}{i.Recibe la estructura generada en i., dos valores de ISBN y retorna la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos (incluidos)}
function contarPrestamosEnUnRango(a:arbol1; isbn1,isbn2:integer):integer;
begin
	if(a<>nil)then begin
		if(a^.dato.ISBN >= isbn1)then begin
			if(a^.dato.ISBN <= isbn2)then contarPrestamosEnUnRango:= 1 + contarPrestamosEnUnRango(a^.hi,isbn1,isbn2) + contarPrestamosEnUnRango(a^.hd,isbn1,isbn2)
			else contarPrestamosEnUnRango:= contarPrestamosEnUnRango(a^.hi,isbn1,isbn2);
		end else contarPrestamosEnUnRango:= contarPrestamosEnUnRango(a^.hd,isbn1,isbn2);
	end else contarPrestamosEnUnRango:= 0;
end;
{----------------------------------------------------------------------}
{////////////////////////Procesos para el arbol 2//////////////////////}
{----------------------------------------------------------------------}{c.Recibe la estructura generada en ii. y retorna el ISBN más pequeño}
function retornarMinISBN(a:arbol2):integer;
begin
	if(a<>nil)then begin
		if(a^.hi = nil)then retornarMinISBN:= a^.ISBN
		else retornarMinISBN:= retornarMinISBN(a^.hi);
	end else retornarMinISBN:= 9999;
end;
{----------------------------------------------------------------------}{e.Recibe la estructura generada en ii., un número de socio y retorna la cantidad de préstamos realizados a dicho socio}
function contarEnLista(l:lista;num:integer):integer;
begin
	if(l<>nil)then begin
		if(l^.dato.numSocio = num)then contarEnLista:= 1 + contarEnLista(l^.sig,num)
		else contarEnLista:= contarEnLista(l^.sig,num);
	end else contarEnLista:= 0;
end;
function contarPrestamosSocio(a:arbol2;num:integer):integer;
begin
	if(a<>nil)then begin contarPrestamosSocio:= contarEnLista(a^.prestamos,num) + contarPrestamosSocio(a^.hi,num) + contarPrestamosSocio(a^.hd,num);
	end else contarPrestamosSocio:= 0;
end;
{----------------------------------------------------------------------}{g.Recibe la estructura generada en ii. y retorna una nueva estructura ordenada por ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó}
function contarElementos(l:lista):integer;
begin
	if(l<>nil)then contarElementos:= 1 + contarElementos(l^.sig)
	else contarElementos:= 0;
end;
procedure agregarAtraslistaArbol2(var pri,ult:lista2; isbn,cant:integer);
var nue:lista2;
begin
	new(nue);
	nue^.dato.ISBN:= isbn;
	nue^.dato.cant:= cant;
	nue^.sig:= nil;
	if(pri = nil)then begin
		pri:=nue;
		ult:=nue;
	end else begin
		ult^.sig:= nue;
		ult:= nue;
	end;
end;
procedure generarListaPorISBNArbol2(a:arbol2;var pri,ult:lista2);
var cant:integer;
begin
	if(a<>nil)then begin
		generarListaPorISBNArbol2(a^.hi,pri,ult);
		cant:= contarElementos(a^.prestamos);
		agregarAtraslistaArbol2(pri,ult,a^.ISBN,cant);
		generarListaPorISBNArbol2(a^.hd,pri,ult);
	end;
end;
{----------------------------------------------------------------------}{h.Recibe la estructura generada en g. y muestra su contenido.}
{Reutilizo imprimirLista2}
{----------------------------------------------------------------------}{j.Recibe la estructura generada en ii., dos valores de ISBN y retorna la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos (incluidos)} 
function contarListaPrestamos(l:lista):integer;
begin
	if(l<>nil)then contarListaPrestamos:= 1 + contarListaPrestamos(l^.sig)
	else contarListaPrestamos:=0;
end;
function contarPrestamosRango(a:arbol2; isbn1,isbn2:integer):integer;
begin
	if(a<>nil)then begin
		if(a^.ISBN >= isbn1)then begin
			if(a^.isbn <= isbn2)then contarPrestamosRango:= contarListaPrestamos(a^.prestamos) + contarPrestamosRango(a^.hi,isbn1,isbn2) + contarPrestamosRango(a^.hd,isbn1,isbn2)
			else contarPrestamosRango:= contarPrestamosRango(a^.hi,isbn1,isbn2);
		end else contarPrestamosRango:= contarPrestamosRango(a^.hd,isbn1,isbn2)
	end else contarPrestamosRango:=0;
end;
{----------------------------------------------------------------------}
{////////////////////////// PROGRAMA PRINCIPAL ////////////////////////}
{----------------------------------------------------------------------}
var
	a1:arbol1;
	a2:arbol2;
	num:integer;
	pri, ult: lista2;
	num1, num2:integer;
	pri2, ult2: lista2;
	
begin
	randomize;
	a1:= nil; a2:= nil; cargarArboles(a1,a2);
	
	writeln('//////////////////////////////////////////////////////////////////');
	writeln('------------------- INCISOS ASOCIADOS AL ARBOL 1 -----------------');
	writeln; imprimirA1(a1); writeln;
	{---------------------------------------------------------------------------}
	writeln('El ISBN mas grande es: ',retornarMaxISBN(a1)); writeln;
	{--------------------------------------------------------------}
	write('Ingrese un numero de socio: '); readln(num);
	writeln('Prestamos realizados al socio ',num,' : ',contarPrestamos(a1,num)); writeln;
	{---------------------------------------------------------------------------}
	writeln('---> Lista de ISBN y cantidad de prestamos asociados:'); 
	pri:= nil; ult:= nil; generarListaPorISBN(a1,pri,ult);
	writeln; imprimirLista2(pri); writeln;
	{---------------------------------------------------------------------------}
	writeln('---> Cantidad de prestamos en un rango: ');writeln;
	write('Ingrese el primer numero: '); readln(num1);
	write('Ingrese el segundo numero (mayor o igual al primero): '); readln(num2);
	writeln('Cantidad de prestamos entre ',num1,' y ',num2,' : ',contarPrestamosEnUnRango(a1,num1,num2)); readln;
	
	
	writeln('//////////////////////////////////////////////////////////////////');
	writeln('------------------- INCISOS ASOCIADOS AL ARBOL 2 -----------------');
	writeln;imprimirA2(a2); writeln;
	{---------------------------------------------------------------------------}
	writeln('El ISBN mas chico es: ',retornarMinISBN(a2)); writeln;
	{---------------------------------------------------------------------------}
	write('Ingrese un numero de socio: ');readln(num);
	writeln('Prestamos realizados al socio ',num,' : ',contarPrestamosSocio(a2,num)); writeln;
	{---------------------------------------------------------------------------}
	writeln('---> Lista de ISBN y cantidad de prestamos asociados:'); 
	pri2:= nil; ult2:= nil; generarListaPorISBNArbol2(a2,pri2,ult2);
	writeln; imprimirLista2(pri2); writeln;
	{---------------------------------------------------------------------------}	
	writeln('---> Cantidad de prestamos en un rango: ');writeln;
	write('Ingrese el primer numero: '); readln(num1);
	write('Ingrese el segundo numero (mayor o igual al primero): '); readln(num2);
	writeln('Cantidad de prestamos entre ',num1,' y ',num2,' : ',contarPrestamosRango(a2,num1,num2)); writeln;
end.
