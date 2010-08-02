require 'spec_helper'

describe Address do

  describe "Validations" do

    subject { Factory.build :address }

    %w(street city zip state).each do |attr|
      it "requires #{attr}" do
        subject.send("#{attr}=", nil)
        should_not be_valid  # uses implicit subject { Address.new }
        subject.errors.on(attr).should_not be_nil
      end
    end

    it 'requires state to be of length 2' do
      subject.state = 'Cal'
      should_not be_valid
      subject.errors.on(:state).should_not be_nil
    end

    it 'requires a state only if country is USA' do
      subject.country = "Canada"
      subject.state = nil
      subject.should be_valid
    end

    describe "missing country" do
      # Extra credit: Flesh out these specs.  The implementation code to make these tests pass requires a Rails
      # feature we haven't covered yet.  Hint: Look up before_validation and read about ActiveRecord callbacks in
      # http://api.rubyonrails.org

      before do
        @valid_attributes = {:street => "123 Main St", :city => "San Francisco", :zip => '12345', :state => 'CA'}
      end

      it "should default the country to USA if missing" do
        @valid_attributes[:country].should be_nil
        addr = Address.create(@valid_attributes)
        addr.should_not be_new_record
        addr.country.should == 'USA'
      end
      it "should leave the country unchanged if it's given" do
        @valid_attributes[:country] = "Mexico"
        addr = Address.create(@valid_attributes)
        addr.should_not be_new_record
        addr.country.should == 'Mexico'
      end
    end
  end

  describe "Association" do
    before do
      @valid_attributes = {:street => "123 Main St", :city => "San Francisco", :zip => '12345', :state => 'CA'}
    end

    it "should respond to :people" do
      addr = Address.new
      addr.should respond_to(:person)
    end

    it "should allow creation of a person" do

      addr = Address.create!(@valid_attributes)

      lambda {
        addr.create_person(:first_name => "Joe", :last_name => "Smith")
      }.should change(Person, :count).by(1)
    end
  end

end
