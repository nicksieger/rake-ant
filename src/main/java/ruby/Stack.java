package ruby;

@SuppressWarnings({"unchecked"})
public class Stack<T> {
    private T[] stack = (T[]) new Object[10];
    private int top = -1;

    public boolean isEmpty() {
        return top < 0;
    }

    public boolean isFull() {
        return top >= stack.length - 1;
    }

    public T peek() {
        if (isEmpty()) {
            throw new StackUnderflowError();
        }

        return stack[top];
    }

    public T pop() {
        T o = peek();
        top--;
        return o;
    }

    public void push(T o) {
        if (isFull()) {
            throw new StackOverflowError();
        }
        stack[++top] = o;
    }
}
