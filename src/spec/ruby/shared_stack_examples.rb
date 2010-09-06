shared_examples_for "non-empty Stack" do

  it { should_not be_empty }

  it "should return the top item when sent #peek" do
    subject.peek.should == @last_item_added
  end

  it "should NOT remove the top item when sent #peek" do
    subject.peek.should == @last_item_added
    subject.peek.should == @last_item_added
  end

  it "should return the top item when sent #pop" do
    subject.pop.should == @last_item_added
  end

  it "should remove the top item when sent #pop" do
    subject.pop.should == @last_item_added
    unless subject.empty?
      subject.pop.should_not == @last_item_added
    end
  end

end

shared_examples_for "non-full Stack" do

  it { should_not be_full }

  it "should add to the top when sent #push" do
    subject.push "newly added top item"
    subject.peek.should == "newly added top item"
  end

end
