package ruby;

public class Greeter {
    private final String message;

    public Greeter() {
        this.message = "there";
    }

    public Greeter(String message) {
        this.message = message;
    }

    public void sayHello() {
        System.out.println("Hello " + message + "!");
    }

    public static void main(String[] args) {
        Greeter greeter;
        if (args.length > 0) {
            greeter = new Greeter(args[0]);
        } else {
            greeter = new Greeter();
        }
        greeter.sayHello();
    }
}
