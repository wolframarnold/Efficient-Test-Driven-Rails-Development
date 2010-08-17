Factory.define(:person) do |p|
  p.first_name "Sally"
  p.last_name "Miller"
end

Factory.define(:message) do |m|
  m.association :sender, :factory => :person
  m.association :recipient, :factory => :person
end

Factory.define(:read_message, :parent => :message) do |m|
  m.read_at Time.now
end

Factory.define(:address) do |a|
  a.association :person
  a.city "San Francisco"
  a.street "123 Main St"
  a.zip "94103"
  a.state "CA"
end

# We cannot "inherit" from the :person factory here, because Factory Girl's inheritance
# is unaware of STI (Single Table Inheritance in Rails).
# I don't know of a way to avoid repeating a minimal customer factory here.  Is there a way
# to DRY this up?

Factory.define(:customer) do |c|
  c.sequence(:first_name) { |n| "Sally#{n}" }
  c.sequence(:last_name) { |n| "Porter#{n}" }
end

Factory.define(:order) do |o|
  o.association :customer
end

Factory.define(:item) do |i|
  i.sequence(:name) {|n| "Product #{n}"}
  i.sequence(:price) {|n| 399.00 + n}
end

Factory.define(:order_item) do |oi|
  oi.association :item
  oi.association :order
end
