{a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por código de producto. De cada producto deben quedar almacenados su código, 
la cantidad total de unidades vendidas y el monto total. De cada venta se cargan código de venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. 
El ingreso de las ventas finaliza cuando se lee el código de venta 0.
b. Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el menor código de producto.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro.
e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos valores recibidos (sin incluir) como parámetros.}

Program ImperativoClase4;

type 
	venta = record
		codigoVenta: integer;
        codigoProducto: integer;
		cantUnidades: integer;
		precioUnitario: real;
    end;
    productoVendido = record
        codigo: integer;
        cantTotalUnidades: integer;
        montoTotal: real;
    end;
    arbol = ^nodoArbol;
    nodoArbol = record
		dato: productoVendido;
        HI: arbol;
        HD: arbol;
    end;
 //--------------------------------------------------------------------- {Almacene los productos vendidos en una estructura eficiente para la búsqueda por código de producto.}   
procedure ModuloA (var a: arbol);

	Procedure CargarVenta (var v: venta);
	begin
		v.codigoVenta:= random (51) * 100;
		If (v.codigoVenta <> 0)then begin
			v.codigoProducto:= random (100) + 1;
			v.cantUnidades:= random(15) + 1;
			v.precioUnitario:= (100 + random (100))/2;
        end;
	end;  
	
	Procedure InsertarElemento (var a: arbol; elem: venta);
	
		Procedure ArmarProducto (var p: productoVendido; v: venta);
		begin
			p.codigo:= v.codigoProducto;
			p.cantTotalUnidades:= v.cantUnidades;
			p.montoTotal:= v.cantUnidades * v.precioUnitario;
		end;
		
	var p: productoVendido;
	begin
		if (a = nil) then begin
			new(a);
			ArmarProducto(p, elem);
			a^.dato:= p; 
			a^.HI:= nil; 
			a^.HD:= nil;
        end else if (elem.codigoProducto = a^.dato.codigo)then begin
            a^.dato.cantTotalUnidades:= a^.dato.cantTotalUnidades + elem.cantUnidades;
            a^.dato.montoTotal:= a^.dato.montoTotal + (elem.cantUnidades * elem.precioUnitario);
        end else if (elem.codigoProducto < a^.dato.codigo) then 
			InsertarElemento(a^.HI, elem)
        else 
			InsertarElemento(a^.HD, elem); 
	end;

var unaVenta: venta;  
begin
	writeln; 
	writeln('---- Ingreso de ventas y armado de arbol de productos --->');
	writeln;
	a:= nil;
	CargarVenta(unaVenta);
	while(unaVenta.codigoVenta <> 0) do begin
		InsertarElemento (a, unaVenta);
		CargarVenta (unaVenta);
	end;
end;
//---------------------------------------------------------------------- {Imprime el contenido del árbol ordenado por código de producto}
procedure ModuloB(a: arbol);

	procedure ImprimirArbol (a: arbol);
	begin
		if (a <> nil) then begin
			if (a^.HI <> nil) then ImprimirArbol (a^.HI);
			writeln ('Codigo producto: ', a^.dato.codigo, ' _ Unidades: ', a^.dato.cantTotalUnidades, ' _ Monto total: ', a^.dato.montoTotal:2:2);
			if (a^.HD <> nil) then ImprimirArbol (a^.HD);
		end;
	end;

begin
	writeln('----- Modulo B ----->'); writeln;
	if (a = nil) then writeln ('Arbol vacio')
	else ImprimirArbol (a);
	writeln; 
end;
//---------------------------------------------------------------------- {Retorna el menor código de producto}
procedure ModuloC (a: arbol);

	function ObtenerMinimo (a: arbol): integer;
	begin
		if (a = nil) then ObtenerMinimo:= 9999
		else if (a^.HI = nil) then ObtenerMinimo:= a^.dato.codigo
        else ObtenerMinimo:= ObtenerMinimo (a^.HI);
	end;
   
var menor: integer;
begin
	writeln('----- Modulo C ----->'); writeln;
	write('Menor codigo de producto: '); 
	menor:= ObtenerMinimo (a);
	if (menor = 9999) then writeln ('Arbol vacio')
	else writeln (menor); 
	writeln;
end;
//---------------------------------------------------------------------- {Retorna la cantidad de códigos que existen en el árbol que son menores que un valor recibido como parámetro}
procedure ModuloD (a: arbol);

	function CantidadDeCodigosMenores (a:arbol; cod:integer): integer;
	var cant:integer;
	begin
		if(a<>nil)then begin
			cant:=0;
			if(a^.dato.codigo < cod)then 
				cant:=1;
			CantidadDeCodigosMenores:= cant + CantidadDeCodigosMenores(a^.HI,cod) + CantidadDeCodigosMenores(a^.HD,cod);
		end else
			CantidadDeCodigosMenores:= 0;
	end;
   
var cantidad, unCodigo: integer;
begin
	writeln ('----- Modulo D ----->'); writeln;
	write('Ingresar un codigo: '); readln (unCodigo); writeln;
	cantidad:= CantidadDeCodigosMenores (a, unCodigo);
	writeln('La cantidad de codigos menores al codigo ', unCodigo, ' es: ', cantidad);
	writeln;
end;
//----------------------------------------------------------------------
{Recibe la estructura, dos códigos y retorna el monto total entre todos los códigos de productos comprendidos entre los dos valores recibidos (sin incluir)}
procedure ModuloE (a: arbol);
  
	{function SumarEnRango (a: arbol; codigo1, codigo2: integer): real; --------------------------> Recorre todo el arbol.
	var monto:real;
	begin
		if(a<>nil)then begin
			monto:=0;
			if(a^.dato.codigo > codigo1)and(a^.dato.codigo < codigo2)then 
				monto:= a^.dato.montoTotal;
			SumarEnRango:= monto + SumarEnRango(a^.HI,codigo1,codigo2) + SumarEnRango(a^.HD,codigo1,codigo2);
		end else
			SumarEnRango:=0;
	end;}
	
	function SumarEnRango (a: arbol; codigo1, codigo2: integer): real;
	var monto:real;
	begin
		monto:=0;
		if(a<>nil)then begin
			if(a^.dato.codigo > codigo1)then begin
				if(a^.dato.codigo < codigo2)then begin
					monto:= a^.dato.montoTotal;
					SumarEnRango:= monto + SumarEnRango(a^.HI,codigo1,codigo2) + SumarEnRango(a^.HD,codigo1,codigo2);
				end else
					SumarEnRango:= monto + SumarEnRango(a^.HI,codigo1,codigo2);
			end else
				SumarEnRango:= monto + SumarEnRango(a^.HD,codigo1,codigo2);
		end else
			SumarEnRango:= monto;
	end;
	
var codigo1, codigo2: integer; montoTotal: real;
begin
	writeln ('----- Modulo E ----->');writeln;
	write('Ingrese primer codigo de producto: '); readln(codigo1);
	write('Ingrese segundo codigo de producto (mayor al primer codigo): '); readln(codigo2);
	writeln;
	montoTotal:= SumarEnRango(a,codigo1,codigo2);
	if (montoTotal = 0) then writeln ('No hay codigos entre ', codigo1, ' y ', codigo2)
	else writeln('El monto total entre el codigo ', codigo1, ' y el codigo ', codigo2, ' es: ', montoTotal:1:2); 
	writeln;
end;
//-------------------------PROGRAMA PRINCIPAL---------------------------
var a: arbol; 
begin
	randomize;
	ModuloA (a);
	ModuloB (a);
	ModuloC (a);
	ModuloD (a);
	ModuloE (a);   
end.
