require 'spec_helper'

describe Item do

  subject { Factory.build(:item) }

  %w(name price).each do |attr|
    specify "requires #{attr}" do
      subject.send("#{attr}=",nil)
      should_not be_valid
      subject.errors.on(attr).should_not be_nil
    end
  end

  context "Popularity ranking" do
    before do
      @items = 3.times.inject([]) { |res,i| res << Factory(:item) }
      # create order items records with 2 * Item0, 5 * Item1, 1 * Item2
      @order_items = 2.times.inject([]) { |res,i| res << Factory(:order_item, :item => @items[0])} +
                     5.times.inject([]) { |res,i| res << Factory(:order_item, :item => @items[1])} +
                     1.times.inject([]) { |res,i| res << Factory(:order_item, :item => @items[2])}
      Item.count.should == 3
      OrderItem.count.should == 8
    end

    it 'returns items ranked by frequency of appearance in orders' do
      Item.by_popularity.should == [@items[1], @items[0], @items[2]]
    end
  end

end
