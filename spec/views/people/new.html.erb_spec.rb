require 'spec_helper'

describe 'people/new' do
  before do
    assigns[:person] = Person.new   # need to set up variable that would otherwise be assigned in the controller
    render                          # tries to render the file specified in the describe block
  end

  it 'has a form posting to /people' do
    response.should have_tag("form[action=/people]")
  end
end
