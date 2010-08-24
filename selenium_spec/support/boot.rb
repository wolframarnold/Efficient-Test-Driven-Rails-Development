require 'rubygems'
gem "warnold-selenium-client", ">=1.2.19"
require "selenium/client"
gem "activesupport", ">=2.3.5"
require 'active_support'
begin
  require 'page'
rescue LoadError => e
  require 'support/page' if e.message =~ /page$/
end

Page.selenium_driver = Selenium::Client::Driver.new \
    :host => "localhost",
    :port => 4444,
    :browser => "*firefox",
    :url => "http://localhost:3000",
    :timeout_in_second => 10

