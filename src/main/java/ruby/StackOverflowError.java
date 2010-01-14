package ruby;

public class StackOverflowError extends Exception {
    public StackOverflowError() {
    }
    public StackOverflowError(String message) {
        super(message);
    }
}
