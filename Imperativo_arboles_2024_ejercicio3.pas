{3. Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de Informática y los almacene en una estructura de datos. 
La información que se lee es legajo, código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. 
La estructura generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y su cantidad de finales aprobados (nota mayor o igual a 4).
d. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe retornar los legajos y promedios de los alumnos cuyo promedio 
supera el valor ingresado.}

program arbolesActividad3;
type
//------Final rendido:
	date = record
		dia: integer;
		mes: integer;
		anio: integer;
	end;
	finalRend = record
		legajo: integer;
		codigo: integer;
		fecha: date;
		nota: real;
	end;
//------Lista de finales rendidos
	finalLista = record
		codigo: integer;
		fecha: date;
		nota: real;
	end; 
	lista = ^nodo;
	nodo = record
		dato:finalLista;
		sig:lista;
	end;
//------Arbol de alumnos organizado por número de legajo
	arbol = ^nodo2;
	nodo2 = record
		legajo:integer;
		finales:lista;
		hi: arbol;
		hd: arbol;
	end;
//------Alumno promedio:
	alumno = record
		legajo: integer;
		promedio: real;
	end;
	promedios = ^nodo3;
	nodo3 = record
		dato:alumno;
		sig:promedios;
	end;
//----------------------------------------------------------------------
procedure cargarArbol(var a:arbol);
	procedure generarFecha(var d:date);
	begin
		d.dia:=random(30)+1;
		d.mes:=random(12)+1;
		d.anio:=random(5)+20;
	end;
	procedure generarFinal(var f:finalRend);
	var fecha:date;
	begin
		f.legajo:=random(19);
		if(f.legajo<>0)then begin
			f.codigo:=random(9)+30;
			generarFecha(fecha);
			f.fecha:=fecha;
			f.nota:=random(9)+2;
		end;
	end;
	procedure agregarAdelante(var l:lista;f:finalRend);
	var nue:lista;
	begin
		new(nue);
		nue^.dato.codigo:=f.codigo;
		nue^.dato.fecha:=f.fecha;
		nue^.dato.nota:=f.nota;
		nue^.sig:=l;
		l:=nue;
	end;
	procedure insertarNodo(var a:arbol; f:finalRend);
	begin
		if(a=nil)then begin
			new(a);
			a^.legajo:=f.legajo;
			a^.finales:=nil;
			a^.hi:=nil;
			a^.hd:=nil;
			agregarAdelante(a^.finales,f);
		end else begin
			if(f.legajo = a^.legajo)then agregarAdelante(a^.finales,f)
			else if(f.legajo < a^.legajo)then insertarNodo(a^.hi,f)
			else insertarNodo(a^.hd,f);
		end;		
	end;
var
	f:finalRend;
begin
	a:=nil;
	generarFinal(f);
	while(f.legajo<>0)do begin
		insertarNodo(a,f);
		generarFinal(f);
	end;
end;
//----------------------------------------------------------------------
procedure imprimirFinales(l:lista);
begin
	if(l<>nil)then begin
		write(' _ Codigo de materia: ',l^.dato.codigo); 
		write('  Fecha: ',l^.dato.fecha.dia,'/',l^.dato.fecha.mes,'/',l^.dato.fecha.anio);
		writeln('  Nota: ',l^.dato.nota:1:1);
		imprimirFinales(l^.sig);
	end;
end;
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		writeln('-----------------------------------------------------');
		writeln('Numero de legajo: ',a^.legajo);
		imprimirFinales(a^.finales);
		imprimirArbol(a^.hi);
		imprimirArbol(a^.hd);
	end;
end;
//----------------------------------------------------------------------
{b.Retorna la cantidad de alumnos con legajo impar}
function cantidadLegajosImpar(a:arbol):integer;
begin
	if(a<>nil)then begin
		cantidadLegajosImpar:= (a^.legajo MOD 2) + cantidadLegajosImpar(a^.hi) + cantidadLegajosImpar(a^.hd)	
	end else
		cantidadLegajosImpar:=0;
end;
//--------------------------------------------------------------------->
{c.Informa, para cada alumno, su legajo y cantidad de finales aprobados (nota mayor o igual a 4)}
function contarAprobados(l:lista):integer;
begin
	if(l<>nil)then begin
		if(l^.dato.nota >=4)then contarAprobados:= contarAprobados(l^.sig) + 1
		else contarAprobados:= contarAprobados(l^.sig);
	end else contarAprobados:=0;
end;
procedure informarFinalesAprobados(a:arbol);
begin
	if(a<>nil)then begin
		writeln('Alumno: ',a^.legajo,' _ Cantidad de finales aprobados: ',contarAprobados(a^.finales));
		informarFinalesAprobados(a^.hi);
		informarFinalesAprobados(a^.hd);
	end;
end;
//--------------------------------------------------------------------->
{d.Retorna los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.
Necesito: 
	Posicionarme en un nodo.
	Recorrer la lista de finales rendidos sumando las notas y contando los finales para luego calcular la nota promedio.
	Comparar la nota promedio con la nota ingresada.
	Si la supera: 
		Cargo el legajo y el promedio en un nuevo registro.
		Agrego el registro a una lista.
	Paso al siguiente nodo.
}
procedure agregarAlumno(var pun:promedios;leg:integer;prom:real);
var nue:promedios;
begin
	new(nue);
	nue^.dato.legajo:= leg;
	nue^.dato.promedio:=prom;
	nue^.sig:= pun;
	pun:=nue;
end;
procedure recorrerLista(l:lista; var tot:real; var cant:integer);
begin
	if(l<>nil)then begin
		tot:= tot + l^.dato.nota; cant:=cant+1;
		recorrerLista(l^.sig,tot,cant);
	end;
end;
procedure promedioSuperior(a:arbol; valor:real; var pun:promedios);
var prom,tot:real; cant:integer;
begin
	if(a<>nil)then begin
		tot:=0;cant:=0; recorrerLista(a^.finales,tot,cant);
		prom:= tot/cant;
		if(prom > valor)then begin
			agregarAlumno(pun,a^.legajo,prom);
		end;
		promedioSuperior(a^.hi,valor,pun);
		promedioSuperior(a^.hd,valor,pun);
	end;		
end;
procedure imprimirPromedios(p:promedios);
begin
	if(p<>nil)then begin
		writeln('Legajo: ',p^.dato.legajo,' _ Promedio: ',p^.dato.promedio:1:1);
		imprimirPromedios(p^.sig);
	end;
end;
//--------------------------------------------------------------------->
var a:arbol; num:real; l:promedios;
begin
	randomize;
	cargarArbol(a);
	imprimirArbol(a); writeln;
	writeln('-----------------------------------------------------');
	writeln('Cantidad de alumnos con legajo impar: ',cantidadLegajosImpar(a));
	writeln('-----------------------------------------------------');
	informarFinalesAprobados(a);
	writeln('-----------------------------------------------------');
	writeln('Ingrese un numero: ');readln(num);
	l:=nil;
	promedioSuperior(a,num,l);
	writeln('Listado de alumnos cuyo promedio supera ',num:1:1,' :');
	imprimirPromedios(l);
end.
