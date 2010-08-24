class Homepage < Page

  # =========================
  # Things to do on Home Page
  # =========================

  def self.visit
    selenium_driver.open('/')
    Homepage.new
  end

  # ==========================
  # Things to see on Home Page
  # ==========================

end
