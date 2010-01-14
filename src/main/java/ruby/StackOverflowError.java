package ruby;

public class StackOverflowError extends RuntimeException {
    public StackOverflowError() {
    }
    public StackOverflowError(String message) {
        super(message);
    }
}
