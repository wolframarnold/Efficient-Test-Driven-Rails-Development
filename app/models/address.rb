class Address < ActiveRecord::Base

  validates_presence_of :street, :city, :zip

  before_save :set_country_if_missing

  belongs_to :person

  private

  def set_country_if_missing
    self.country = 'USA' if self.country.blank?
  end
end
