require 'spec_helper'

describe OrderItem do

  it 'has an order' do
    should respond_to(:order)
  end
  it 'has an item' do
    should respond_to(:item)
  end

end
