require 'selenium_spec_helper'

describe "Creating a new person" do

  before do
    @page = NewPersonPage.visit
  end

  it 'redirects to index page' do
    @page.fill_out_first_name('Joe').
          fill_out_last_name('Smith').
          click_submit.
          on_index_page?.should be_true
  end

end
