class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_items, :dependent => :destroy
  has_many :items, :through => :order_items
end
