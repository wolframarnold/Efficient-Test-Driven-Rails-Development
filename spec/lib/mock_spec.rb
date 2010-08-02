require 'spec_helper'

describe "Using Mocks" do
  it 'with inlined method stubs' do
    m = mock("A mock", :foo => "Hello")
    m.should respond_to(:foo)
    m.foo.should == 'Hello'
  end
  it 'with explicit method stubs' do
    m = mock("A mock")
    m.stub!(:foo => 'Hello')
    m.should respond_to(:foo)
    m.foo.should == 'Hello'
  end
  it 'with expectations' do
    m = mock("A mock")
    m.should_receive(:foo)
    m.should respond_to(:foo)

    m.foo
  end
end
