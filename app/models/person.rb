class Person < ActiveRecord::Base

  validates_presence_of :first_name, :last_name

  named_scope :find_by_names_starting_with, lambda { |term|
    { :conditions => ["first_name LIKE :term OR last_name LIKE :term", { :term => "#{term}%" } ] }
  }

  has_many :addresses
  has_many :messages, :foreign_key => "recipient_id"

  def joe?
    first_name == "Joe"
  end

end
