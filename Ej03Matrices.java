/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema1;

//Paso 1. importar la funcionalidad para generar datos aleatorios
import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ej03Matrices {

    public static void main(String[] args) {
	//Paso 2. iniciar el generador aleatorio     
	GeneradorAleatorio.iniciar();
        //Paso 3. definir la matriz de enteros de 5x5 e iniciarla con nros. aleatorios 
        int[][] matriz = new int[5][5];
        int i, j;
        
        for(i=0;i<5;i++){
            for(j=0;j<5;j++){
                matriz[i][j]= GeneradorAleatorio.generarInt(10);
            }
        }
        //Paso 4. mostrar el contenido de la matriz en consola
        for(i=0;i<5;i++){
            System.out.print("| ");
            for(j=0;j<5;j++){
                System.out.print(matriz[i][j]+" ");
            }
            System.out.println("|");
        }
        //Paso 5. calcular e informar la suma de los elementos de la fila 1
        int suma = 0;
        for (j=0;j<5;j++){
            suma = suma + matriz[1][j];
        }
        System.out.println("Suma de los elementos de la fila 1 = "+suma);
        //Paso 6. generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz. 
        //        Luego, imprima el vector.
        int [] vector;
        vector = new int[5];
        for (i=0;i<5;i++){
            suma = 0;
            for (j=0;j<5;j++){
                suma = suma + matriz[j][i];
            }
            vector[i] = vector[i] + suma;
        }
        System.out.println("Suma de los elementos de cada columna:");
        System.out.print("| ");
        for (i=0;i<5;i++){ System.out.print(vector[i]+" "); }
        System.out.println("|");
        
        //Paso 7. lea un valor entero e indique si se encuentra o no en la matriz. 
        //En caso de encontrarse indique su ubicación (fila y columna)
        //   y en caso contrario imprima "No se encontró el elemento".
        System.out.println("Ingrese un numero entero: ");
        int valor = Lector.leerInt(); int fil= -1;int col=-1;
        boolean ok = false;
        i=0;
        while((i<5)&&(!ok)){
            j=0;
            while((j<5)&&(!ok)){
                if(matriz[i][j] == valor){
                    ok = true;
                    fil = i;
                    col = j;
                }
                j++;
            }
            i++;
        }
        if(ok){System.out.println("Fila: "+(fil+1)+" Columna: "+(col+1));
        }else{ System.out.println("No se encontro el valor"); }
        
        
    }
}
