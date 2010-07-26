class Message < ActiveRecord::Base

  validates_presence_of :sender,:recipient

  belongs_to :sender, :class_name => "Person"
  belongs_to :recipient, :class_name => "Person"
  
end
