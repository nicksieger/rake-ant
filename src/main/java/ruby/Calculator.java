package ruby;

public class Calculator {
    private Stack<Integer> stack = new Stack<Integer>();

    public void push(int i) {
        stack.push(i);
    }

    public void add() {
        Integer total = 0;
        while (!stack.isEmpty()) {
            total += stack.pop();
        }
        stack.push(total);
    }

    public int getResult() {
        return stack.peek();
    }

}
