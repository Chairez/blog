require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class EliminarComentarioSeltest < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :phantomjs
    @base_url = "http://localhost:9292/posts"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_eliminar_comentario_sel
    @driver.find_element(:link, "Mostrar").click
    @driver.find_element(:link, "Eliminar Comentario").click
    assert_match /^¿Estás seguro[\s\S]$/, close_alert_and_get_its_text()
  end
  
  def element_present?(how, what)
    ${receiver}.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    ${receiver}.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = ${receiver}.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
