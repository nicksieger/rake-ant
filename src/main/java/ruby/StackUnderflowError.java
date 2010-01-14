package ruby;

public class StackUnderflowError extends RuntimeException {
    public StackUnderflowError() {
    }
    public StackUnderflowError(String message) {
        super(message);
    }
}
