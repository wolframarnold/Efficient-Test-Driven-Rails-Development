class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses, :force => true do |t|
      t.belongs_to :person
      t.string :street
      t.string :city
      t.string :zip
      t.string :country

      t.timestamps
    end
    add_index :addresses, :person_id
  end

  def self.down
    drop_table :addresses
  end
end
