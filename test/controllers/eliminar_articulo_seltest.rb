# encoding: UTF-8
require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class EliminarArticuloSeltest < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://localhost:9292/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
  def test_eliminar_articulo_sel
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Mi primer blog").click
    assert !60.times{ break if (element_present?(:link, "Crear artículo") rescue false); sleep 1 }
    @driver.find_element(:link, "Crear artículo").click
    assert !60.times{ break if (element_present?(:link, "Volver") rescue false); sleep 1 }
    @driver.find_element(:id, "post_titulo").clear
    @driver.find_element(:id, "post_titulo").send_keys "eliminar unico"
    @driver.find_element(:id, "post_texto").clear
    @driver.find_element(:id, "post_texto").send_keys "eliminar unico"
    @driver.find_element(:name, "commit").click
    assert !60.times{ break if (element_present?(:link, "Volver") rescue false); sleep 1 }
    @driver.find_element(:link, "Volver").click
    assert !60.times{ break if (element_present?(:xpath, "//tr[9]/td") rescue false); sleep 1 }
    @driver.find_element(:xpath, "(//a[contains(text(),'Eliminar')])[8]").click
    assert !element_present?(:xpath, "//tr[9]/td")
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
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
    alert = @driver.switch_to().alert()
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
