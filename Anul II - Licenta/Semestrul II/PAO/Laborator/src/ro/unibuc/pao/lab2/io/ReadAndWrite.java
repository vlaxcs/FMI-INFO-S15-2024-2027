package ro.unibuc.pao.lab2.io;

import java.util.Scanner;

public class ReadAndWrite{
    static Scanner scanner = new Scanner(System.in);

    public int getIntegerInput(){
        System.out.println("Input (int): ");
        return scanner.nextInt();
    }
}