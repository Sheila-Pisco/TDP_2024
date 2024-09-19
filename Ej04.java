package tema1;

//Paso 1. importar la funcionalidad para generar datos aleatorios
import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ej04 {
    
    public static void main(String[] args) {
	//Paso 2. iniciar el generador aleatorio     
	GeneradorAleatorio.iniciar();
        //Paso 3. definir la matriz de enteros de 8x4
        int[][] matriz = new int[8][4];
        int i, j;
        for(i=0;i<8;i++){
            for(j=0;j<4;j++){
                matriz[i][j]= 0;
            }
        }
        //Paso 4. a cada persona se le pide el nro. de piso y nro. de oficina a la cual quiere concurrir. 
        //La llegada de personas finaliza al indicar un nro. de piso 9.
        int Piso , Oficina;
        System.out.println("Ingrese Nro. de piso (1 a 9): ");
        Piso = Lector.leerInt();
        while(Piso != 9){
            System.out.println("Ingrese Nro. de Oficina (1 a 4): ");
            Oficina = Lector.leerInt();
            Piso--;
            Oficina--;
            matriz[Piso][Oficina]++;
            System.out.println("Ingrese Nro. de piso: ");
            Piso = Lector.leerInt();
        }
        //Paso 5. mostrar el contenido de la matriz en consola
        for(i=7;i>-1;i--){
            System.out.print("| ");
            for(j=0;j<4;j++){
                System.out.print(matriz[i][j]+" ");
            }
            System.out.println("|");
        }
        //informar la cantidad de personas que concurrieron a cada oficina de cada piso. 
        for(i=0;i<8;i++){
            System.out.println("Piso "+(i+1));
            for(j=0;j<4;j++){
                System.out.println("Oficina "+(j+1)+" : "+matriz[i][j]+" personas.");
            }
            System.out.println();
        }
        
        
        
        
    
        
    }
    
    
}
