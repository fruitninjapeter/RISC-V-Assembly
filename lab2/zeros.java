// Peter Vu and Mady Giut and Phillip Chen
import java.util.Scanner;

public class zeros {
    public static void main(String[] args) {
        System.out.println("Welcome to the Zeros program.\n");
        Scanner prompt = new Scanner(System.in);
        String Choice = "y";
        while(Choice.equals("y")) {
            System.out.println("Please enter a number: ");
            Integer input = prompt.nextInt();
            int count = 0;
            for(int i = 31; i >= 0; i--) {
                if ((input >> i) != 0) {
                    break;
                }
                count++;
            }
            System.out.println("The number of leading zeros is: " + count);
            System.out.println("Continue (y/n)?: ");
            Choice = prompt.next();
            System.out.println();
        }
        System.out.println("Exiting");
    }
}