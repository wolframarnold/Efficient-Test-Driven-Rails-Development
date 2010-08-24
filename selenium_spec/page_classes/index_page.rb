class IndexPage < Page

  # =========================
  # Things to do on Home Page
  # =========================

  def self.visit
    selenium_driver.open('/people')
    IndexPage.new
  end

  # ==========================
  # Things to see on Home Page
  # ==========================

  def on_index_page?
    selenium_driver.location =~ /people/
  end

end
