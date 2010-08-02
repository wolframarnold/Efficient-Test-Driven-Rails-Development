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
  a.city "San Francisco"
  a.street "123 Main St"
  a.zip "94103"
  a.state "CA"
end
