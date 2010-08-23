class Person < ActiveRecord::Base

  validates_presence_of :first_name, :last_name

  named_scope :find_by_names_starting_with, lambda { |term|
    { :conditions => ["first_name LIKE :term OR last_name LIKE :term", { :term => "#{term}%" } ] }
  }

  has_many :addresses
  has_many :messages, :foreign_key => "recipient_id"
  has_many :unread_messages, :class_name => "Message", :foreign_key => "recipient_id", :conditions => {:read_at => nil}

  accepts_nested_attributes_for :addresses, :reject_if => :all_blank, :allow_destroy => true

  def joe?
    first_name == "Joe"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
