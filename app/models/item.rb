class Item < ActiveRecord::Base

  validates_presence_of :name, :price

  has_many :order_items, :dependent => :destroy

  named_scope :by_popularity, {
          :include => :order_items,
          :group   => 'order_items.item_id',
          :order   => 'COUNT(order_items.item_id) DESC'
  }

end
