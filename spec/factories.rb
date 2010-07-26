Factory.define(:person) do |p|
  p.first_name "Sally"
  p.last_name "Miller"
end

Factory.define(:message) do |m|
  m.association :sender, :factory => :person
  m.association :recipient, :factory => :person
end
