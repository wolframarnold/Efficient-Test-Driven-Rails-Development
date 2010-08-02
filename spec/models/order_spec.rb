require 'spec_helper'

describe Order do
  it 'has customer' do
    should respond_to(:customer)
  end

  it 'has many order_items' do
    should respond_to(:order_items)
  end

  it 'has many items' do
    should respond_to(:items)
  end

  context "Finders" do

    before do
      @order_item = Factory(:order_item)
      @order      = @order_item.order
      @item       = @order_item.item
    end

    it 'retrieves items' do
      @order.items.should == [@item]
    end
  end

end
