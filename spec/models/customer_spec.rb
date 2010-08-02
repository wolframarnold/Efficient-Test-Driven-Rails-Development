require 'spec_helper'

describe Customer do

  it 'is a Person' do
    should be_kind_of(Person)
  end

  it 'has orders' do
    should respond_to(:orders)
  end

  it 'retrieves orders' do
    order = Factory(:order)
    order.customer.orders.should == [order]
  end

  it 'can retrieve all the items purchased' do
    order_item = Factory(:order_item)
    item = order_item.item
    order = order_item.order
    order.customer.items.should == [item]
  end

  it "finds a customer's most recent order" do
    customer = Factory(:customer)
    order1 = Factory(:order, :customer => customer, :created_at => 10.days.ago)
    order2 = Factory(:order, :customer => customer, :created_at => 1.day.ago)

    customer.orders.most_recent.should == order2
  end

  context "Loyalty search" do

    before do
      @order1 = Factory(:order)
      @customer1 = @order1.customer
      @order2 = Factory(:order, :created_at => 91.days.ago)
      @customer2 = @order2.customer
      @item1 = Factory(:item)
      @item2 = Factory(:item)
      @order1.order_items.create(:item => @item1)
      @order1.order_items.create(:item => @item2)
    end

    it 'finds customers who placed orders in the last 90 days' do
      Customer.loyal_last_90_days.should == [@customer1]
    end

    it 'finds customers who placed orders for a total of at least 2 items' do
      Customer.min_2_items.should == [@customer1]
    end

    it 'finds customers who orders 2 or more items within the last 90 days' do
      @order2.order_items.create(:item => @item1)
      @order2.order_items.create(:item => @item2)

      # check non-trivial
      Customer.min_2_items.should == [@customer1, @customer2]

      Customer.loyal_last_90_days.min_2_items.should == [@customer1]
    end
  end
end
