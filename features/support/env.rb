require 'cucumber'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'net/http'
require 'capybara/poltergeist'
require 'phantomjs'

$ENVIRONMENT = 'LOCAL_CHROME'
$SIZE = '1200'
$OS = 'MACOS'


if $ENVIRONMENT.eql?('LOCAL_CHROME')
  Capybara.default_driver = :selenium
  Capybara.default_max_wait_time = 300
  if $OS == 'MACOS'
    chromeDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/mac', 'chromedriver')
  elsif $OS == 'WINDOWS'
    chromeDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/windows', 'chromedriver.exe')
  elsif $OS == 'LINUX'
    chromeDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/linux', 'chromedriver')
  end
  Capybara.register_driver :selenium do |app|
    driver = Capybara::Selenium::Driver.new(app, :browser => :chrome, driver_path: chromeDriver_path)
  end
  Capybara.current_session.driver.browser.manage.window.resize_to($SIZE, 1200)

elsif $ENVIRONMENT.eql?('HEADLESS_CHROME')
  Capybara.default_max_wait_time = 20
  Capybara.default_driver = :headless_chrome
  Capybara.javascript_driver = :headless_chrome
  if $OS == 'MACOS'
    chromeDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/mac', 'chromedriver')
  elsif $OS == 'WINDOWS'
    chromeDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/windows', 'chromedriver.exe')
  elsif $OS == 'LINUX'
    chromeDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/linux', 'chromedriver')
  end
  Capybara.register_driver :chrome do |app|
    driver = Capybara::Selenium::Driver.new(app, :browser => :chrome, driver_path: chromeDriver_path)
  end

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument 'headless'
    options.add_argument 'disable-gpu'
    options.add_argument 'disable-popup-blocking'
    options.add_argument 'no-sandbox'
    Capybara::Selenium::Driver.new app, browser: :chrome, driver_path: chromeDriver_path, options: options
  end
end


