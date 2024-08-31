{2. Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio. Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. 
Finalizar con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto. Los códigos repetidos van a la derecha.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la cantidad total de unidades vendidas.
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la lista de las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles.
b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad total de productos vendidos en la fecha recibida.
c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto con mayor cantidad total de unidades vendidas.
d. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto con mayor cantidad de ventas.}

program ImperativoClase3Ejercicio2;
type
//---------------------------------------------------------------------- {Arbol 1}
	venta = record 
		codigo:integer;
		fecha:string;
		unidades:integer;
	end;
	arbol1 = ^nodo1;
	nodo1 = record
		dato:venta;
		hi:arbol1;
		hd:arbol1;
	end;
//---------------------------------------------------------------------- {Arbol 2}	
	producto = record 
		codigo:integer;
		tot_unidades:integer;
	end;
	arbol2 = ^nodo2;
	nodo2 = record
		dato:producto;
		hi:arbol2;
		hd:arbol2;
	end;
//---------------------------------------------------------------------- {Arbol 3}
	ventaProd = record
		fecha:string;
		unidades:integer;
	end;
	lista = ^nodoLista;
	nodoLista = record
		dato:ventaProd;
		sig:lista;
	end;
	arbol3 =^nodo3;
	nodo3 = record
		codigo:integer;
		ventas:lista;
		hi:arbol3;
		hd:arbol3;
	end; 
//---------------------------------------------------------------------- {Proceso para generar la venta}
procedure cargarVenta(var v:venta);
	var vFechas:array [0..9] of string = ('10/09/2024', '12/09/2024', '13/09/2024', '15/09/2024', '16/09/2024', '18/09/2024', '19/09/2024', '20/09/2024', '22/09/2024', '23/09/2024');
	begin
		v.codigo:=random(11)*10;
		if(v.codigo<>0)then begin
			v.fecha:=vFechas[random(10)];
			v.unidades:=random(9)+1;
		end;
	end;
//---------------------------------------------------------------------- {Proceso para generar el Arbol1}
procedure agregarNodoArbol1(var a1:arbol1; v:venta);
begin 
	if(a1 = nil)then begin
		new(a1);
		a1^.dato:=v;
		a1^.hi:=nil;
		a1^.hd:=nil;
	end else begin
		if(v.codigo < a1^.dato.codigo) then 
			agregarNodoArbol1(a1^.hi,v)
		else if(v.codigo >= a1^.dato.codigo) then
			agregarNodoArbol1(a1^.hd,v);
	end;
end;
//---------------------------------------------------------------------- {Proceso para generar el Arbol2}
procedure agregarNodoArbol2(var a2:arbol2; v:venta); 
begin 
	if(a2 = nil)then begin
		new(a2);
		a2^.dato.codigo:= v.codigo; {Como solo necesito dos campos de la venta, los asigno según corresponde}
		a2^.dato.tot_unidades:= v.unidades;
		a2^.hi:=nil;
		a2^.hd:=nil;
	end else begin
		if(v.codigo = a2^.dato.codigo)then	
			a2^.dato.tot_unidades:= a2^.dato.tot_unidades + v.unidades
		else begin
			if(v.codigo < a2^.dato.codigo) then 
				agregarNodoArbol2(a2^.hi,v)
			else
				agregarNodoArbol2(a2^.hd,v);
		end;
	end;
end;
//---------------------------------------------------------------------- {Procesos para generar el Arbol3}
procedure agregarAdelante(var l:lista;v:venta);
var nue:lista;
begin
	new(nue);
	nue^.dato.fecha:= v.fecha;
	nue^.dato.unidades:= v.unidades;
	nue^.sig:=l;
	l:=nue;
end;
procedure agregarNodoArbol3(var a3:arbol3;v:venta);
begin 
	if(a3 = nil)then begin
		new(a3);
		a3^.codigo:=v.codigo;
		a3^.ventas:=nil; 
		a3^.hi:=nil;
		a3^.hd:=nil;
		agregarAdelante(a3^.ventas,v);
	end else begin
		if(v.codigo = a3^.codigo) then 
			agregarAdelante(a3^.ventas,v)
		else if(v.codigo < a3^.codigo)then
			agregarNodoArbol3(a3^.hi,v)
		else
			agregarNodoArbol3(a3^.hd,v);
	end;
end;
//---------------------------------------------------------------------- {Procesos para imprimir}
procedure imprimirArbol1(a1:arbol1);
begin
	if(a1<>nil)then begin
		writeln('Codigo: ',a1^.dato.codigo,'_ Fecha: ',a1^.dato.fecha,' _ Unidades: ',a1^.dato.unidades);
		imprimirArbol1(a1^.hi);
		imprimirArbol1(a1^.hd);
	end;
end;
procedure imprimirArbol2(a2:arbol2);
begin
	if(a2<>nil)then begin
		writeln('Codigo: ',a2^.dato.codigo,' _ Total unidades vendidas: ',a2^.dato.tot_unidades);
		imprimirArbol2(a2^.hi);
		imprimirArbol2(a2^.hd);
	end;
end;
procedure imprimirLista(l:lista);
begin
	if(l<>nil)then begin
		writeln('Fecha: ',l^.dato.fecha,' _ Unidades vendidas: ',l^.dato.unidades);
		imprimirLista(l^.sig);
	end;
end;
procedure imprimirArbol3(a3:arbol3);
begin
	if(a3<>nil)then begin
		writeln('Codigo de producto: ',a3^.codigo);
		writeln('Lista de ventas:');
		imprimirLista(a3^.ventas);
		writeln;
		if(a3^.hi<>nil)then
			imprimirArbol3(a3^.hi);
		if(a3^.hd<>nil)then
			imprimirArbol3(a3^.hd);
	end;	
end;
//----------------------------------------------------------------------
function sumarProductosFecha(a:arbol1;f:string):integer;
var suma:integer;
begin
	if(a<>nil)then begin
		suma:= sumarProductosFecha(a^.hi,f) + sumarProductosFecha(a^.hd,f);
		if(a^.dato.fecha = f)then 
			suma:= suma + a^.dato.unidades;
		sumarProductosFecha:= suma;
	end else
		sumarProductosFecha:=0;
end;

procedure codigoMaxUnidades(a:arbol2;var max,cod:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.tot_unidades > max)then begin
			max:= a^.dato.tot_unidades;
			cod:= a^.dato.codigo;
		end;
		codigoMaxUnidades(a^.hi,max,cod);
		codigoMaxUnidades(a^.hd,max,cod);
	end;
end;

function contarVentas(l:lista):integer;
begin
	if(l<>nil)then
		contarVentas:= 1 + contarVentas(l^.sig)
	else 
		contarVentas:=0;
end;

procedure codigoMaxVentas(a:arbol3;var max,cod:integer);
var ventas:integer;
begin
	if(a<>nil)then begin
		ventas:= contarVentas(a^.ventas);
		if(ventas > max)then begin
			max:= ventas;
			cod:= a^.codigo;
		end;
		codigoMaxVentas(a^.hi,max,cod);
		codigoMaxVentas(a^.hd,max,cod); 
	end;	
end;
//---------------------------PROGRAMA PRINCIPAL-------------------------
var 
	a1:arbol1;
	a2:arbol2;
	a3:arbol3;
	v:venta;
	fecha:string;
	max,codMax,codMaxVentas:integer;
begin
	//---------->Genero las ventas y los arboles
	randomize;
	a1:=nil; a2:=nil; a3:=nil;
	cargarVenta(v);
	while(v.codigo<>0)do begin
		agregarNodoArbol1(a1,v);
		agregarNodoArbol2(a2,v);
		agregarNodoArbol3(a3,v);
		cargarVenta(v);
	end;
	imprimirArbol1(a1); writeln;
	imprimirArbol2(a2); writeln;
	imprimirArbol3(a3); writeln;
	//----------->Inciso b
	writeln('Ingrese una fecha (dd/mm/aaaa): '); readln(fecha);
	writeln('La cantidad total de productos vendidos el ',fecha,' es: ',sumarProductosFecha(a1,fecha)); writeln;
	//----------->Inciso c
	max:=-1; codigoMaxUnidades(a2,max,codMax); 
	writeln('Codigo de producto con mayor cantidad de unidades vendidas: ',codMax); writeln;
	//----------->Inciso d
	max:=-1; codigoMaxVentas(a3,max,codMaxVentas);
	writeln('Codigo de producto con mayor cantidad de ventas: ',codMaxVentas); writeln;
end.
