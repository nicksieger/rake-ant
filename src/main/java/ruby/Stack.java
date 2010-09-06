package ruby;

public class Stack {
    private Object[] stack;
    private int top;

    public Stack() {
        stack = new Object[10];
        top = -1;
    }

    public boolean isEmpty() {
        return top < 0;
    }

    public boolean isFull() {
        return top >= stack.length - 1;
    }

    public Object peek() {
        if (isEmpty()) {
            throw new StackUnderflowError();
        }

        return stack[top];
    }

    public Object pop() {
        Object o = peek();
        top--;
        return o;
    }

    public void push(Object o) {
        if (isFull()) {
            throw new StackOverflowError();
        }
        stack[++top] = o;
    }
}
