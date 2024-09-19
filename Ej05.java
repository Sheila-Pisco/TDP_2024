package tema1;
import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class Ej05 {

        public static void main(String[] args){
        GeneradorAleatorio.iniciar();
        
        int [][] matriz = new int[5][4];
        int i,j;
        
        //Lea desde teclado las calificaciones de los cinco clientes
        //para cada uno de los aspectos y almacene la información en una estructura. 
        System.out.println("Calificaciones: ");
        
        for (i=0;i<5;i++){
            System.out.println("Cliente "+i+": ");
            System.out.print(" _ Atencion: ");
            matriz[i][0]= Lector.leerInt();
            System.out.print(" _ Calidad de la comida: ");
            matriz[i][1]= Lector.leerInt();
            System.out.print(" _ Precio: ");
            matriz[i][2]= Lector.leerInt();
            System.out.print(" _ Ambiente: ");
            matriz[i][3]= Lector.leerInt();
        }
        
        System.out.println();
        for (i=0;i<5;i++){
            System.out.print("| ");
            for (j=0;j<4;j++){
                System.out.print(matriz[i][j]+" ");
            }
            System.out.println("|");
        }
        
        System.out.println();
        //imprima la calificación promedio obtenida por cada aspecto.
        int suma; 
        for (j=0;j<4;j++){
            suma = 0;
            for(i=0;i<5;i++){
                suma = suma + matriz[i][j];
            }
            System.out.println("Calificacion promedio del aspecto "+j+" : "+(double)suma/5);
        }
        }
}