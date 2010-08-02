class AddStateToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :state, :string
  end

  def self.down
    remove_column :addresses, :state
  end
end
