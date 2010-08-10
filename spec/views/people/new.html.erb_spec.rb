require 'spec_helper'

describe 'people/new' do
  before do
    p = Person.new
    p.addresses.build      # same as what controller's #new would do, initialize a blank address record
    assigns[:person] = p   # need to set up variable that would otherwise be assigned in the controller
    render                 # tries to render the file specified in the describe block
  end

  it 'has a form posting to /people' do
    response.should have_tag("form[action=/people]")
  end

  %w(street city zip state).each do |attr|
    it "has an address field for #{attr}" do
      response.should have_tag("input[name*=#{attr}]")
    end
  end

end
