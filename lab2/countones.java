// Mady Giut and Phillip Chen and Peter Vu
import java.util.Scanner;

public class countones {
    public static void main(String[] args) {
        System.out.println("Welcome to the CountOnes program.\n");
        Scanner prompt = new Scanner(System.in);
        String Choice = "y";
        while(Choice.equals("y")) {
            System.out.println("Please enter a number: ");
            Integer input = prompt.nextInt();
            int count = 0; // From the signed integer value (ex: 1, -5, 8, 90, -22), count number of bits set to 1
            for(int i = 0; i < 32; i++) {
                if((input & 1 << i) != 0) {
                    count++;
                }
            }
            System.out.println("The number of bits set is: " + count);
            System.out.println("Continue (y/n)?: ");
            Choice = prompt.next();
            System.out.println();
        }
        System.out.println("Exiting");
    }
}
