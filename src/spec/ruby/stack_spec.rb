require 'java'
java_import "ruby.Stack"
java_import "ruby.StackOverflowError"
java_import "ruby.StackUnderflowError"
require File.dirname(__FILE__) + '/shared_stack_examples'

describe Stack do

  context "empty" do

    subject { Stack.new }

    it { should be_empty }

    it_should_behave_like "non-full Stack"

    it "should complain when sent #peek" do
      lambda { subject.peek }.should raise_error(StackUnderflowError)
    end

    it "should complain when sent #pop" do
      lambda { subject.pop }.should raise_error(StackUnderflowError)
    end

  end

  context "with one item" do

    before :all do
      @last_item_added = 3
    end

    subject { Stack.new.tap {|stack| stack.push @last_item_added } }

    it_should_behave_like "non-empty Stack"
    it_should_behave_like "non-full Stack"

  end

  context "with one item less than capacity" do

    before :all do
      @last_item_added = 9
    end

    subject { Stack.new.tap {|stack| (1..9).each { |i| stack.push i } } }

    it_should_behave_like "non-empty Stack"
    it_should_behave_like "non-full Stack"

  end

  context "full" do

    before :all do
      @last_item_added = 10
    end

    subject { Stack.new.tap {|stack| (1..10).each { |i| stack.push i } } }

    it { should be_full }

    it_should_behave_like "non-empty Stack"

    it "should complain on #push" do
      lambda { subject.push Object.new }.should raise_error(StackOverflowError)
    end

  end
end
