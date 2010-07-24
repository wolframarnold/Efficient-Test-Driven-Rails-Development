class Person < ActiveRecord::Base

  validates_presence_of :first_name, :last_name

  def joe?
    first_name == "Joe"
  end

  def self.find_by_names_starting_with(term)
    term += '%'
    Person.all(:conditions => ["first_name LIKE :term OR last_name LIKE :term", {:term => term}])
  end
end
