class Person < ActiveRecord::Base

  validates_presence_of :first_name, :last_name

  def joe?
    first_name == "Joe"
  end
end
