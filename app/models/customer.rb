class Customer < Person

  has_many :orders, :dependent => :destroy do
    def most_recent
      first(:order => 'orders.created_at DESC')
    end
  end

  named_scope :loyal_last_90_days, {
     :include => :orders,
     :conditions => ['orders.created_at >= ?', 90.days.ago]
  }

  named_scope :min_2_items, {
    :include => { :orders => :order_items },
    :group   => 'people.id',
    :conditions => ['order_items.id > 0'],  # Hack: This condition is not necessary from a SQL perspective.
                                            # However, Rails's eager loading with :include changed in behavior in Rails 2.2
                                            # to _not_ eager load (even if :include is specified) unless the eager loaded (i.e. joined)
                                            # table(s) show(s) up in the :conditions clause.  For some reason, it's not good enough to have
                                            # it show up in the :having clause. Probably a Rails bug.
    :having => 'COUNT(order_items.id) >= 2'
  }

  named_scope :min_2_items_last_90_days, {
    :include => { :orders => :order_items },
    :conditions => ['orders.created_at >= ?', 90.days.ago],
    :group   => 'order_items.item_id',
    :having => 'COUNT(order_items.id) >= 2'
  }

  def items(opts={})
    Item.all({:include => {:order_items => {:order => :customer}}, :conditions => {'orders.customer_id' => self.id}}.reverse_merge(opts))
  end
  
end
