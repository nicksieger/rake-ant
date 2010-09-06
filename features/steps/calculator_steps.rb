import Java::ruby.Calculator

Given /^I have entered (\d+) into the calculator$/ do |n|
  @calculator ||= Calculator.new
  @calculator.push n.to_i
end

When /^I press add$/ do
  @calculator.add
end

Then /^the result should be (\d+) on the screen$/ do |n|
  @calculator.result.should == n.to_i
end
