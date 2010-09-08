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

  it 'can make order with associated objects' do
    order = Factory(:order)
    order.order_items.should have(2).items
    order.order_items.each do |oi|
      oi.should be_kind_of(OrderItem)
      oi.item.should be_kind_of(Item)
    end
  end

  context "has_many :through" do

    before do
      @order = Factory(:order)
    end

    it 'retrieves items' do
      @order.items.should == @order.order_items.map(&:item)
    end
  end

end
