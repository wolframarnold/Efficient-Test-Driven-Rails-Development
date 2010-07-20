require 'spec_helper'

describe Person do

  before do
    @valid_attributes = {
      :first_name => "Joe",
      :last_name => "Example"
    }
  end

  it 'must have a first_name' do
    p = Person.new
    p.should_not be_valid  # calls p.valid?
    p.errors.on(:first_name).should_not be_nil
  end

  it 'must have a last_name' do
    p = Person.new
    p.should_not be_valid  # calls p.valid?
    p.errors.on(:last_name).should_not be_nil
  end

  it "creates a new instance given valid attributes" do
    lambda {
      Person.create(@valid_attributes)
    }.should change { Person.count }.by(1)
  end

  it "saves the first_name" do
    p = Person.create(:first_name => "John")
    p.first_name.should == "John"
  end

  it "verifies that first_name is joe" do
    p = Person.create(:first_name => 'Joe')
    p.should be_joe
  end

end
