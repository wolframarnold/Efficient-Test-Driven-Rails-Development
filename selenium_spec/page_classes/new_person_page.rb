class NewPersonPage < Page

  # =========================
  # Things to do on Home Page
  # =========================

  def self.visit
    selenium_driver.open('/people/new')
    NewPersonPage.new
  end

  def fill_out_first_name(name)
    selenium_driver.type("person_first_name",name)
    self
  end

  def fill_out_last_name(name)
    selenium_driver.type("person_last_name",name)
    self
  end

  def click_submit
    selenium_driver.click("commit")
    IndexPage.new
  end

  # ==========================
  # Things to see on Home Page
  # ==========================

end
