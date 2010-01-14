require 'java'
import "ruby.Stack"
import "ruby.StackOverflowError"
import "ruby.StackUnderflowError"
require File.dirname(__FILE__) + '/shared_stack_examples'

describe Stack, " (empty)" do

  subject do
    @stack = Stack.new
  end

  it { should be_empty }

  it_should_behave_like "non-full Stack"

  it "should complain when sent #peek" do
    lambda { @stack.peek }.should raise_error(StackUnderflowError)
  end

  it "should complain when sent #pop" do
    lambda { @stack.pop }.should raise_error(StackUnderflowError)
  end

end

describe Stack, " (with one item)" do

  subject do
    @last_item_added = 3
    @stack = Stack.new
    @stack.push @last_item_added
    @stack
  end

  it_should_behave_like "non-empty Stack"
  it_should_behave_like "non-full Stack"

end

describe Stack, " (with one item less than capacity)" do

  subject do
    @stack = Stack.new
    (1..9).each { |i| @stack.push i }
    @last_item_added = 9
    @stack
  end

  it_should_behave_like "non-empty Stack"
  it_should_behave_like "non-full Stack"

end

describe Stack, " (full)" do

  subject do
    @stack = Stack.new
    (1..10).each { |i| @stack.push i }
    @last_item_added = 10
    @stack
  end

  it { should be_full }

  it_should_behave_like "non-empty Stack"

  it "should complain on #push" do
    lambda { @stack.push Object.new }.should raise_error(StackOverflowError)
  end

end
