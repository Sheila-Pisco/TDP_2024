
package tema1;

//Paso 1: Importar la funcionalidad para lectura de datos
import PaqueteLectura.Lector;

public class Ej02Jugadores {

    public static void main(String[] args) {
        //Paso 2: Declarar la variable vector de double 
        double[] vector;
        
        //Paso 3: Crear el vector para 15 double 
        vector = new double[16];
        
        //Paso 4: Declarar indice y variables auxiliares a usar
        int i; double suma;
        
        //Paso 6: Ingresar 15 numeros (altura), cargarlos en el vector, ir calculando la suma de alturas
        suma = 0.0;
        for (i=1;i<=15;i++) {
            System.out.println("Ingrese altura del jugador "+ i +" :");
            vector[i] = Lector.leerDouble();
            suma = suma + vector[i];
        }  
        System.out.println("Suma de alturas: "+ suma);
        
        //Paso 7: Calcular el promedio de alturas, informarlo
        double promedio = suma/15.0;
        System.out.println("Pomedio de alturas: "+ promedio +" metros.");
        //Paso 8: Recorrer el vector calculando lo pedido (cant. alturas que están por encima del promedio)
        int cantAlturas = 0; 
        for (i=1;i<=15;i++) {
            if (vector[i] > promedio) cantAlturas++; 
        }
        //Paso 9: Informar la cantidad.
        System.out.println("Cantidad de alturas que superan el promedio: " + cantAlturas);
    } 
}
