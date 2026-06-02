package ro.unibuc.pao.lab2.arrays;

import java.sql.Array;
import java.util.Arrays;
import java.lang.Math;

import ro.unibuc.pao.lab2.io.ReadAndWrite;

public class ArrayClass {

    public static void main(String[] args) {

        float  value_array[] = new float[3];

        float[] value_array_dup = new float[4];

        value_array[0] = 10.0f;
        value_array[1] = 10.f;
        value_array[2] = 3;

        float sum = 0;
        for (var number : value_array){
            sum += number;
        }
        System.out.println("Suma: " + sum);

        Arrays.sort(value_array);

        System.out.println("Sorted array: ");
        for (var number : value_array){
            System.out.print(number + " ");
        }
        System.out.println();

        long[] math_grades = {12L, 56L, 1224L};
        long[] cs_grades = {1L, 2L, 3L};

        boolean equals = Arrays.equals(math_grades, cs_grades);
        if (equals){
            System.out.println("Sunt egale");
        } else {
            System.out.println("Nu sunt egale");
        }

        ReadAndWrite raw = new ReadAndWrite();
        int n = raw.getIntegerInput();
        for (int i = 0; i <= n; ++i){
            System.out.print(i + " ");
        }

        int a = raw.getIntegerInput();
        int b = raw.getIntegerInput();

        int max = Math.max(a, b);
        System.out.println(max);

        int number_count = raw.getIntegerInput();
        float[] odd = new float[number_count];
        float[] even = new float[number_count];
        int even_count = 0, odd_count = 0;
        for (int i = 0; i < number_count; ++i){
            System.out.print("[" + i + "] ");
            int new_number = raw.getIntegerInput();
            if (new_number % 2 == 0){
                even[even_count++] = new_number;
            } else {
                odd[odd_count++] = new_number;
            }
        }

        System.out.println("Even array: ");
        for (var number : even){
            System.out.print(number + " ");
        }
        System.out.println();
        System.out.println("Odd array: ");
        for (var number : odd){
            System.out.print(number + " ");
        }
    }
}
