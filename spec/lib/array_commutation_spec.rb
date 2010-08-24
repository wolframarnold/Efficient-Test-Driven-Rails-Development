require 'spec_helper'

describe "Array Commutation" do
  it 'should return true when arrays are commutatively equal' do
    [1,2,3].should be_commutative_with([2,3,1])
  end
  it 'should return false when arrays are not commutatively equal' do
   [1,2,3].should_not
    be_commutative_with([2,3,4])
  end
  it 'should return false when arrays differ only by duplicates' do
   [1,2,3].should_not
    be_commutative_with([1,2,3,3])
  end
end
