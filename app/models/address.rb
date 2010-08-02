class Address < ActiveRecord::Base

  validates_presence_of :street, :city, :zip
  validates_presence_of :state, :if => Proc.new { |addr| addr.country == "USA"}
  validates_length_of :state, :is => 2, :allow_blank => true 

  before_validation :set_country_if_missing

  belongs_to :person

  private

  def set_country_if_missing
    self.country = 'USA' if self.country.blank?
  end
end
