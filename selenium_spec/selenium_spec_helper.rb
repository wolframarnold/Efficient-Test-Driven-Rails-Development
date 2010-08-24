require 'rubygems'
gem "rspec", ">=1.3.0"
require "spec"
require "selenium/rspec/spec_helper"
require 'support/boot'

Dir.glob(File.join('support','**','*.rb')).each do |f|
  require f
end
Dir.glob(File.join('page_classes','**','*.rb')).each do |f|
  require f
end

Spec::Example::ExampleGroup.class_eval do
  attr_reader :selenium_driver  # this is needed for the report formatter
  alias :page :selenium_driver
end

Spec::Runner.configure do |config|

  config.before(:all) do
    @selenium_driver = Page.selenium_driver
  end

  config.prepend_before(:each) do
    @selenium_driver.start_new_browser_session
  end

  # The system capture need to happen BEFORE closing the Selenium session
  config.append_after(:each) do
    @selenium_driver.close_current_browser_session
  end

end
