{2. Descargar el programa ImperativoEjercicioClase3.pas de la clase anterior e incorporar lo necesario para:
i. Informar el número de socio más grande. Debe invocar a un módulo recursivo que retorne dicho valor.
ii. Informar los datos del socio con el número de socio más chico. Debe invocar a un módulo recursivo que retorne dicho socio.
iii. Leer un valor entero e informar si existe o no existe un socio con ese valor. Debe invocar a un módulo recursivo que reciba el valor leído y retornar verdadero o falso.
iv. Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos entre los valores leídos. 
Debe invocar a un módulo recursivo que reciba los valores leídos y retorne la cantidad solicitada.}

Program ImperativoClase3;
type 
	rangoEdad = 12..100;
    cadena15 = string [15];
    socio = record
        numero: integer;
        nombre: cadena15;
        edad: rangoEdad;
    end;
    arbol = ^nodoArbol;
    nodoArbol = record
        dato: socio;
        HI: arbol;
        HD: arbol;
    end;
{----------------------------------------------------------------------}
procedure GenerarArbol (var a: arbol);

	Procedure CargarSocio (var s: socio);
	var vNombres:array [0..9] of string = ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
	begin
		s.numero:= random (51);
		if (s.numero <> 0) then begin
			s.nombre:= vNombres[random(10)];
			s.edad:= 12 + random (79);
		end;
	end;  
	Procedure InsertarElemento (var a: arbol; elem: socio);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato:= elem; 
			a^.HI:= nil; 
			a^.HD:= nil;
        end else 
			if (elem.numero < a^.dato.numero) then InsertarElemento(a^.HI, elem)
			else InsertarElemento(a^.HD, elem); 
	end;

var unSocio: socio;  
begin
	writeln;
	writeln ('----- Ingreso de socios y armado del arbol ----->');
	a:= nil;
	CargarSocio (unSocio);
	while (unSocio.numero <> 0)do begin
		InsertarElemento (a, unSocio);
		CargarSocio (unSocio);
	end;
	writeln;
	writeln ('///////////////////////////////////////////////////////');
end;
{----------------------------------------------------------------------}{Informa los datos de los socios en orden creciente}
procedure InformarSociosOrdenCreciente (a: arbol);

	procedure InformarDatosSociosOrdenCreciente (a: arbol);
	begin
		if ((a <> nil) and (a^.HI <> nil))then 
			InformarDatosSociosOrdenCreciente (a^.HI);
		writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		if ((a <> nil) and (a^.HD <> nil))then 
			InformarDatosSociosOrdenCreciente (a^.HD);
	end;

begin
	writeln;
	writeln ('---- Socios en orden creciente por numero de socio --->');
	writeln;
	InformarDatosSociosOrdenCreciente (a);
	writeln;
	writeln ('///////////////////////////////////////////////////////');
end;
{----------------------------------------------------------------------}{Informar el número de socio más grande}
procedure InformarMayorNumeroDeSocio(a:arbol);

	function buscarMayor(a:arbol):integer;
	begin 
		if(a<>nil)then begin
			if(a^.HD = nil)then buscarMayor:=a^.dato.numero
			else buscarMayor:=buscarMayor(a^.HD);
		end;
	end;

begin
	writeln;
	writeln ('----- Informar Mayor Numero de Socio  ----->');
	writeln;
	writeln('El numero de socio mas grande es: ',buscarMayor(a));
end;
{----------------------------------------------------------------------}{Informar los datos del socio con el número de socio más chico}
procedure InformarDatosMenorNumeroDeSocio(a:arbol);

	procedure SocioMenorNumero(a:arbol;var s:socio);
	begin
		if(a<>nil)then begin
			if(a^.HI<>nil)then SocioMenorNumero(a^.HI,s)
			else s:=a^.dato;
		end;
	end;

var s:socio;
begin
	writeln;
	writeln ('----- Informar Datos del Socio Con Menor Numero de Socio ----->');
	writeln;
	SocioMenorNumero(a,s);
	writeln('Numero: ',s.numero,' Nombre: ',s.nombre,' Edad: ',s.edad);
end;
{----------------------------------------------------------------------}{Leer un valor entero e informar si existe o no existe un socio con ese valor}
procedure InformarExistenciaSocio(a:arbol);
	
	function existeSocio(a:arbol;num:integer):boolean;
	begin
		if(a<>nil)then begin
			if(a^.dato.numero = num)then existeSocio:= true
			else if(a^.dato.numero > num)then existeSocio:= existeSocio(a^.HI,num)
			else existeSocio:= existeSocio(a^.HD,num);
		end else existeSocio:= false;
	end;

var valor:integer;
begin
	writeln;
	writeln ('----- Informar Si Existe Socio ----->');
	writeln;
	write('Ingrese un numero: ');readln(valor);
	writeln;
	if(existeSocio(a,valor))then writeln('Socio encontrado')
	else writeln('Socio inexistente');
end;
{----------------------------------------------------------------------}{leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos entre los valores leídos}
procedure InformarSociosEnRango(a:arbol);

	function contarSociosEnRango(a:arbol;n1,n2:integer):integer;
	begin
		if(a<>nil)then begin
			if(a^.dato.numero>n1)then begin
				if(a^.dato.numero<n2)then 
					contarSociosEnRango:= 1 + contarSociosEnRango(a^.HI,n1,n2)+contarSociosEnRango(a^.HD,n1,n2)
				else 
					contarSociosEnRango:= contarSociosEnRango(a^.HI,n1,n2);
			end else 
				contarSociosEnRango:= contarSociosEnRango(a^.HD,n1,n2);	
		end else 
			contarSociosEnRango:=0;
	end;

var num1,num2:integer; 
begin
	writeln;
	writeln ('----- Informar Cantidad de Socios en un Rango ----->');
	writeln;
	write('Ingrese el primer numero: '); readln(num1);
	write('Ingrese el segundo numero (mayor al primero): '); readln(num2);
	writeln('Cantidad de socios entre los valores ingresados: ',contarSociosEnRango(a,num1,num2));
end;
{--------------------------PROGRAMA PRINCIPAL--------------------------}
var a: arbol; 
Begin
	randomize;
	GenerarArbol(a); 
	InformarSociosOrdenCreciente(a);
	{Nuevos modulos}
	InformarMayorNumeroDeSocio(a);
	InformarDatosMenorNumeroDeSocio(a);
	InformarExistenciaSocio(a);
	InformarSociosEnRango(a);
End.
