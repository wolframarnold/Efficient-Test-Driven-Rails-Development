class CreateItemsAndOrderItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2
      t.timestamps
    end

    create_table :order_items do |t|
      t.belongs_to :order
      t.belongs_to :item

      t.timestamps
    end
    add_index :order_items, :order_id
    add_index :order_items, :item_id
  end

  def self.down
    drop_table :items
    drop_table :order_items
  end
end
