class Page
  cattr_accessor :selenium_driver

  def self.start_new_browser_session
    selenium_driver.start_new_browser_session
  end
  def self.close_current_browser_session
    selenium_driver.close_current_browser_session
  end

end
