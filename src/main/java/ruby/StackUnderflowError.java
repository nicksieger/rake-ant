package ruby;

public class StackUnderflowError extends Exception {
    public StackUnderflowError() {
    }
    public StackUnderflowError(String message) {
        super(message);
    }
}
