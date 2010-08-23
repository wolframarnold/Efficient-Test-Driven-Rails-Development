require 'spec_helper'

describe Person do

  before do
    @valid_attributes = {
      :first_name => "Joe",
      :last_name => "Example"
    }
  end

  describe "Validations" do

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

  describe "Custom Finders" do

    before do
      Person.delete_all
      @anna = Factory(:person, :first_name => "Anna", :last_name => "Jones")
      @peter= Factory(:person, :first_name => "Peter", :last_name => "Miller")
      @jona = Factory(:person, :first_name => "Jona", :last_name => "Smith")
    end

    it 'has a method find_by_beginning_of_name' do
      Person.should respond_to(:find_by_names_starting_with)
    end
    
    it 'finds all records whose first or last name starts with the given letters' do
      Person.find_by_names_starting_with("Jon").should == [@anna, @jona]
    end

    it 'should have a LIKE query for first and last name' do
      # Note: This spec tests implementation, something we generally try to avoid.
      # In this case, it's an acceptable exception to double check that the fully expanded search term query meets our expectation.
      Person.find_by_names_starting_with("Jon").proxy_options.should ==
              {:conditions => ["first_name LIKE :term OR last_name LIKE :term", {:term=>"Jon%"}]}
    end
  end

  describe "Associations" do
    it 'has addresses' do
      Person.new.should respond_to(:addresses)
    end

    it 'has messages' do
      Person.new.should respond_to(:messages)
    end
    
    it 'can retrieve messages' do
      p = Factory(:person)
      p.messages.should be_empty
    end

  end

  describe "Nested Attributes" do
    context "creating" do
      subject { Person.new(:first_name => "Joe", :last_name => "Smith") }
      it 'creates an address' do
        lambda {
          subject.attributes = {:addresses_attributes => [{:city => "San Francisco",
                                                           :street => "123 Main St",
                                                           :zip => "94103",
                                                           :state => "CA"}]}
          subject.save!
        }.should change {subject.addresses(true).count}.from(0).to(1)
      end

      it 'ignores an all-blank address record' do
        lambda {
          subject.attributes = {:addresses_attributes => [{:city => "",
                                                           :street => "",
                                                           :zip => "",
                                                           :state => ""}]}
          subject.save!
        }.should_not change(Address, :count)

      end

      it 'ignores new records marked for destruction with _destroy flag' do
        lambda {
          subject.attributes = {:addresses_attributes => [{:city => "San Francisco",
                                                           :street => "123 Main St",
                                                           :zip => "94103",
                                                           :state => "CA",
                                                           :_destroy => '1'}]}
          subject.save!
        }.should_not change(Address, :count)
      end
    end

    context "editing" do
      before {
        @address = Factory(:address)
      }
      subject { @address.person }
      it 'can delete an address via nested attributes and _destroy flag' do
        lambda {
          subject.attributes = {:addresses_attributes => [{:id => @address.id, :city => "San Jose", :_destroy => 1}]}
          subject.save!
        }.should change{subject.addresses(true).count}.by(-1)  # addresses(true) causes a reload
      end
    end
  end
end
