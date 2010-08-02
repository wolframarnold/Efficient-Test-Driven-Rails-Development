class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.belongs_to :customer

      t.timestamps
    end
    add_index :orders, :customer_id
  end

  def self.down
    drop_table :orders
  end
end
