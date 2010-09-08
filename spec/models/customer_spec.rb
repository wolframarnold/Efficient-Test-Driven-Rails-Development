require 'spec_helper'

describe Customer do

  it 'is a Person' do
    should be_kind_of(Person)
  end

  it 'has orders' do
    should respond_to(:orders)
  end

  context "Finders" do

    before do
      @order = Factory(:order)
    end

    it 'retrieves orders' do
      @order.customer.orders.should == [@order]
    end
  
    it 'can retrieve all the items purchased' do
      @order.customer.items.should == @order.items
    end

    it "finds a customer's most recent order" do
      customer = Factory(:customer)
      order1 = Factory(:order, :customer => customer, :created_at => 10.days.ago)
      order2 = Factory(:order, :customer => customer, :created_at => 1.day.ago)

      customer.orders.most_recent.should == order2
    end

  end

  context "Loyalty search" do

    before do
      Order.delete_all
      OrderItem.delete_all
      Item.delete_all
      @order1 = Factory(:order)
      @customer1 = @order1.customer
      @order2 = Factory(:order_with_1_item, :created_at => 91.days.ago)
      @customer2 = @order2.customer
    end

    it 'finds customers who placed orders in the last 90 days' do
      Customer.loyal_last_90_days.should == [@customer1]
    end

    it 'finds customers who placed orders for a total of at least 2 items' do
      Customer.min_2_items.should == [@customer1]
    end

    it 'finds customers who orders 2 or more items within the last 90 days' do
      @order2.items << Factory(:item)

      # check non-trivial, minimum 2 items
      Customer.min_2_items.should == [@customer1, @customer2]

      order3 = Factory(:order_with_1_item)
      customer3 = order3.customer
      # check non-trivial, 90 days
      Customer.loyal_last_90_days.should == [@customer1, customer3]

      Customer.min_2_items.loyal_last_90_days.should == [@customer1] #-- this one gives the wrong result
      # the grouping must be by order_items.item_id to take into account recency, not by people.id
      Customer.min_2_items_last_90_days.should == [@customer1]
    end

    it 'requires that both items be purchased in the last 90 days' do
      Factory(:order_with_1_item, :customer => @customer2)

      Customer.min_2_items_last_90_days.should == [@customer1]
    end
  end
end
