require 'spec_helper'

describe Address do

  describe "Validations" do

    %w(street city zip).each do |attr|
      it "requires #{attr}" do
        a = Address.new
        a.should_not be_valid
        a.errors.on(attr).should_not be_nil
      end
    end
#    it "should require a street" do
#      a = Address.new
#      a.should_not be_valid
#      a.errors.on(:street).should_not be_nil
#    end
#
#    it "should require a city" do
#      a = Address.new
#      a.should_not be_valid
#      a.errors.on(:city).should_not be_nil
#    end
#
#    it "should require a zip" do
#      a = Address.new
#      a.should_not be_valid
#      a.errors.on(:zip).should_not be_nil
#    end

    describe "missing country" do
      # Extra credit: Flesh out these specs.  The implementation code to make these tests pass requires a Rails
      # feature we haven't covered yet.  Hint: Look up before_validation and read about ActiveRecord callbacks in
      # http://api.rubyonrails.org
      before do
        @valid_attributes = {:street => "123 Main St", :city => "San Francisco", :zip => '12345'}
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
end
