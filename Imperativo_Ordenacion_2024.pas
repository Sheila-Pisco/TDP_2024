//Imperativo-Ordenación:
{1.Se desea procesar la información de las ventas de productos de un comercio (como máximo 50). De cada venta se conoce:
	El día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades). 
	El código debe generarse automáticamente (random) y la cantidad se debe leer. Elingreso de las ventas finaliza con el día de venta 0 (no se procesa).
	Implementar un programa que invoque los siguientes módulos:}
program actividad1;
const
	dfv1 = 50;
type
	venta = record
		dia:integer; 
		codPro:integer; 
		cantUni:integer;
	end;
	vectorVentas = array[1..dfv1]of venta;
//a. Un módulo que retorne la información de las ventas en un vector.
procedure cargarVectorVentas(var v:vectorVentas;var dl:integer);
	procedure leerVenta(var v:venta);
	begin
		write('Dia: ');readln(v.dia);
		if(v.dia<>0)then begin
			write('Codigo del producto: ');readln(v.codPro); write('Cantidad de unidades vendidas: ');readln(v.cantUni);
		end;
	end;
var ven:venta;
begin
	leerVenta(ven);
	while(ven.dia<>0)do begin
		dl:=dl+1;v[dl]:= ven; leerVenta(ven);
	end;
end;
//b. Un módulo que muestre el contenido del vector resultante del punto a).
procedure imprimirVectorVentas(v:vectorVentas; dl:integer);
var 
	i:integer;
begin
	for i:=1 to dl do begin
		write('| Dia: ',v[i].dia,' - '); write('Codigo :',v[i].codPro,' - '); writeln('Unidades: ',v[i].cantUni,' |');
	end;
end;
//c. Un módulo que ordene el vector de ventas por código.
//d. Un módulo que muestre el contenido del vector resultante del punto c).
procedure ordenarVentasPorCodigo(var v:vectorVentas; dl:integer);
var i,j:integer; actual:venta;
begin
	for i:=2 to dl do begin
		actual:= v[i]; j:=i-1;
		while(j>0)and(v[j].codPro > actual.codPro)do begin
			v[j+1]:=v[j]; j:=j-1;
		end;
		v[j+1]:= actual;
	end;
end;
//e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos valores que se ingresan como parámetros.
//f. Un módulo que muestre el contenido del vector resultante del punto e).
procedure eliminarRango(var v:vectorVentas;var dl:integer; ini,fin:integer);
var i,j:integer;
begin
	if(ini>fin)then begin
		i:=ini; ini:=fin; fin:=i;
	end;
	i:=1;
	while(i<=dl)and(ini>v[i].codPro)do 
		i:=i+1;
	while(i<=dl)and(v[i].codPro<=fin)do begin
		for j:= i to(dl-1)do 
			v[j]:=v[j+1];
		dl:=dl-1;
	end; 
end;
//g. Un módulo q retorne la info (ordenada por código de producto de menor a mayor) de c/código par de producto, junto a la cant. total de productos vendidos.
//h. Un módulo q muestre la información obtenida en el punto g).
procedure retornarInfoPares();
begin
end;

var	
	v:vectorVentas;
	dl,inf,sup:integer;
begin
	dl:=0;
	cargarVectorVentas(v,dl);
	imprimirVectorVentas(v,dl);
	writeln('........................');
	ordenarVentasPorCodigo(v,dl);
	imprimirVectorVentas(v,dl);
	writeln('........................');
	writeln('Eliminar elementos en un rango:'); 
	writeln('Ingrese el limite inferior:'); readln(inf);
	writeln('Ingrese el limite superior:'); readln(sup);
	eliminarRango(v,dl,inf,sup);
	imprimirVectorVentas(v,dl);//hasta acá funciona.
	writeln('........................');
end.

{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
De cada oficinase ingresa el código de identificación, DNI del propietario y valor de la expensa. 
La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:}
program actividad2;
const
	dfofi = 30;
type
	oficina = record
		codID: integer;
		dni: integer;
		expensa: real;
	end;
	vectorOficinas = array[1..dfofi] of oficina;
//a. Genere un vector, sin orden, con a lo sumo las 30 oficinas que administra. 	
procedure cargarVectorOficinas(var v:vectorOficinas;var dl:integer);
	procedure leerOficina(var ofi:oficina);
	begin
		writeln('Codigo de identificacion: ');readln(ofi.codID);
		if(ofi.codID<>-1)then begin
			writeln('DNI del propietario: ');readln(ofi.dni);
			writeln('Valor de la expensa: ');readln(ofi.expensa);
		end;
	end;	
var ofi:oficina;
begin
	leerOficina(ofi);
	while(dl<dfofi)and(ofi.codID<>-1)do begin
		dl:=dl+1;
		v[dl]:=ofi;
		leerOficina(ofi);
	end;
end;
procedure imprimirVectorOficinas(v: vectorOficinas; diml:integer);
var i:integer;
begin
	for i:=1 to diml do begin
		write('| Codigo: ',v[i].codID,' _ DNI: '); write(v[i].dni,' _ Valor: $'); writeln(v[i].expensa:1:1,' |');
	end;
end;
//b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
procedure ordenarPorInsercion(var v:vectorOficinas; diml:integer);
var i,j:integer; actual:oficina;
begin
	for i:=2 to diml do begin
		actual:=v[i];
		j:=i-1;
		while(j>0)and(v[j].codID > actual.codID)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=actual;
	end;
end;
//c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
procedure ordenarPorSeleccion(var v:vectorOficinas;diml:integer);
var i,j,pos:integer; actual:oficina;
begin
	for i:=1 to diml-1 do begin
		pos:=i;
		for j:=i+1 to diml do begin
			if(v[j].codID<v[pos].codID)then 
				pos:=j;
		end;
		actual:=v[pos];
		v[pos]:=v[i];
		v[i]:=actual;
	end;
end;
var
	v:vectorOficinas;
	diml:integer;
begin
	diml:=0;
	cargarVectorOficinas(v,diml);
	imprimirVectorOficinas(v,diml);
	writeln('--------------------------------------');
	ordenarPorInsercion(v,diml);
	imprimirVectorOficinas(v,diml);
	writeln('--------------------------------------');
	ordenarPorSeleccion(v,diml);
	imprimirVectorOficinas(v,diml);//Funciona.
end.

{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022. 
De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) 
y puntaje promedio otorgado por las críticas. Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:}
program actividad3;
const
	df = 3;
type
	peli = record
		cod:integer;
		gen:integer;
		prom:real;
	end;	
	listaPelis = ^nodo;
	nodo = record
		dato:peli;
		sig:listaPelis;
	end;
	vectorListas = array[1..df] of listaPelis;
//----------------------------------------------------------------------
	mejoresPelis = array[1..df] of peli;	
//a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de género, y retorne en una estructura de datos adecuada. 
//La lectura finaliza cuando se lee el código de la película -1.
procedure inicializarVectorListas(var v:vectorListas);
var i:integer;
begin
	for i:=1 to df do 
		v[i]:=nil;
end;
procedure leerPeli(var p:peli);
begin
	write('Codigo: ');readln(p.cod);
	if(p.cod<>-1)then begin
		write('Genero: ');readln(p.gen);
		write('Puntaje promedio otorgado por las criticas: ');readln(p.prom);
	end;
end;
procedure agregarAtras(var l:listaPelis; p:peli);
var 
	nue,ult:listaPelis;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=nil;
	if(l=nil)then
		l:=nue
	else begin
		ult:=l;
		while(ult^.sig<>nil)do 
			ult:=ult^.sig;
		ult^.sig:=nue;
	end;	
end;
procedure cargarVectorListas(var v:vectorListas);
var p:peli;
begin
	leerPeli(p);
	while(p.cod<>-1)do begin
		agregarAtras(v[p.gen],p);
		leerPeli(p);
	end;
end;
procedure imprimirPeli(p:peli);
begin
	writeln('Codigo: ',p.cod,' _ Genero: ',p.gen,' _ Puntaje: ',p.prom:1:2);
end;
procedure imprimirListaPelis(l:listaPelis);
begin
	while(l<>nil)do begin
		imprimirPeli(l^.dato);
		l:=l^.sig;
	end;
end;
procedure imprimirVectorListas(v:vectorListas);	
var i:integer;
begin
	for i:=1 to df do begin
		writeln(' ');
		imprimirListaPelis(v[i]);
	end;
end;
//b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas, a partir de la estructura generada en a)..
procedure retornarVectorMejoresPelis(v:vectorListas;var m:mejoresPelis);
	procedure encontrarMejorPeli(l:listaPelis;var p:peli);
	var max:real;
	begin
		max:=-1;
		while(l<>nil)do begin
			if(l^.dato.prom > max)then begin
				p:= l^.dato;
				max:= p.prom;
			end;
			l:=l^.sig;
		end;
	end;
var i:integer; p:peli;
begin
	for i:= 1 to df do 
		if(v[i]<>nil)then begin
			encontrarMejorPeli(v[i],p);
			m[i]:=p;
		end;
end;
procedure imprimirMejores(m:mejoresPelis);
var i:integer;
begin
	for i:=1 to df do
		imprimirPeli(m[i]);
end;
//c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos en la teoría.
procedure ordenarMejores(var m:mejoresPelis);
var i,j:integer; actual:peli;
begin
	for i:=2 to df do begin
		actual:=m[i];
		j:=i-1;
		while(j>0)and(m[j].prom>actual.prom)do begin
			m[j+1]:=m[j];
			j:=j-1;
		end;
		m[j+1]:=actual;
	end;
end;
//d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje, del vector obtenido en el punto c).
procedure imprimirMenoryMayorPuntaje(m:mejoresPelis);
var i:integer; min,max:real; pmin,pmax:peli;
begin
	min:=999;
	max:=1;
	for i:=1 to df do begin
		if(m[i].prom > max)then begin
			pmax := m[i]; max:= pmax.prom;
		end;
		if(m[i].prom>0)and(m[i].prom<min)then begin
			pmin:=m[i]; min:=pmin.prom;
		end;
	end;
	writeln('Codigo de pelicula con mayor puntaje:');
	writeln(pmax.cod);
	writeln('Codigo de pelicula con menor puntaje:');
	writeln(pmin.cod);
end;
var
	v:vectorListas;
	m:mejoresPelis;
begin
	cargarVectorListas(v);
	//imprimirVectorListas(v); writeln('');
	retornarVectorMejoresPelis(v,m); 
	//imprimirMejores(m); writeln('');
	ordenarMejores(m);
	//imprimirMejores(m); writeln('');
	imprimirMenoryMayorPuntaje(m);
end.*)

{4.- Una librería requiere el procesamiento de la información de sus productos. 
De cada producto se conoce: El código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:}
program actividad4;
const
	df = 8;
	r3 = 30;
type
	producto = record
		codigo: integer;
		rubro: 1..df;
		precio: real;
	end;	
	lproductos = ^nodo;
	nodo = record
		dato: producto;
		sig: lproductos;
	end;
	vRubros = array[1..df]of lproductos;
	vRubroTres = array[1..r3] of producto;
//a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada.
//El ingreso de los productos finaliza cuando se lee el precio 0.
procedure inicializarVectorRubros(var v:vRubros);
var
	i:integer;
begin
	for i:=1 to df do
		v[i]:=nil;
end;
procedure leerProducto(var p:producto);
begin
	write('Precio: ');readln(p.precio);
	if(p.precio<>0)then begin
		p.codigo:=random(100)+1;
		p.rubro:=random(df)+1;
	end;
end;
procedure insertarOrdenado(var l:lproductos; p:producto);
var
	ant,act,nue:lproductos;
begin
	new(nue);
	nue^.dato:=p;
	act:=l;
	while(act<>nil)and(act^.dato.codigo<p.codigo)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(l=nil)then
		l:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;	
end;
procedure cargarVectorRubros(var v:vRubros);
var
	p:producto;
begin
	leerProducto(p);
	while(p.precio<>0)do begin
		insertarOrdenado(v[p.rubro],p);
		leerProducto(p);
	end;
end;
//b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
procedure imprimirCodigosPorRubro(v:vRubros);
var
	i:integer;
begin
	for i:=1 to df do begin
		writeln('Rubro ',i,' :');
		while(v[i]<>nil)do begin
			writeln(v[i]^.dato.codigo);
			v[i]:=v[i]^.sig;
		end;
	end;
end;
//c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3.Considerar que puede haber más o menos de 30 productos del rubro 3. 
//Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
procedure generarVectorRubro3(l:lproductos;var v3:vRubroTres; dl:integer);
begin
	while(l<>nil)and(dl<r3)do begin
		dl:=dl+1;
		v3[dl]:=l^.dato;
		l:=l^.sig;
	end;
end;
//d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos métodos vistos en la teoría.
procedure ordenarPorPrecio(var v3:vRubroTres;dl:integer);
var
	i,j,pos:integer; actual:producto;
begin
	for i:=1 to dl-1 do begin
		pos:=i;
		for j:=i+1 to dl do begin
			if(v3[j].precio<v3[pos].precio)then
				pos:=j;
		end;
		//intercambio v[i] y v[pos]
		actual:=v3[pos];
		v3[pos]:=v3[i];
		v3[i]:=actual;
	end;
end;
//e. Muestre los precios del vector resultante del punto d).
procedure imprimirPrecios(v3:vRubroTres;dl:integer);
var
	i:integer;
begin
	for i:=1 to dl do 
		writeln(v3[i].precio);
end;
//f. Calcule el promedio de los precios del vector resultante del punto d).
function calcularPromedioR3(v3:vRubroTres; dl:integer):real;
var
	suma:real;
	i:integer;
begin
	suma:=0;
	for i:=1 to dl do 
		suma:= suma + v3[i].precio;
	calcularPromedioR3:=suma/dl;
end;
var 
	v:vRubros; v3:vRubroTres; dl:integer;
begin
	inicializarVectorRubros(v);
	cargarVectorRubros(v);
	imprimirCodigosPorRubro(v);
	dl:=0;
	generarVectorRubro3(v[3],v3,dl);
	ordenarPorPrecio(v3,dl);
	imprimirPrecios(v3,dl);
	writeln('El promedio de precios del rubro 3 es ',calcularPromedioR3(v3,dl):1:1);
end.
