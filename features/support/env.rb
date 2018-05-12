require 'cucumber'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'net/http'
require 'capybara/poltergeist'
require 'phantomjs'

$ENVIRONMENT = 'LOCAL_CHROME'

if $ENVIRONMENT.eql?('LOCAL_CHROME')
  Capybara.default_driver = :selenium
  Capybara.default_max_wait_time = 300
  chromeDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/mac', 'chromedriver')
  #Selenium::WebDriver::Chrome.driver_path = chromeDriver_path

  Capybara.register_driver :selenium do |app|
    driver = Capybara::Selenium::Driver.new(app, :browser => :chrome, driver_path:chromeDriver_path)
  end
  Capybara.current_session.driver.browser.manage.window.resize_to(1200,1200)

elsif $ENVIRONMENT.eql?('HEADLESS_CHROME')
  Capybara.default_max_wait_time = 20
  Capybara.default_driver = :headless_chrome
  Capybara.javascript_driver = :headless_chrome
  chromeDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/mac', 'chromedriver')
  Capybara.register_driver :chrome do |app|
    driver = Capybara::Selenium::Driver.new(app, :browser => :chrome, driver_path:chromeDriver_path)
  end

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument 'headless'
    options.add_argument 'disable-gpu'
    options.add_argument 'disable-popup-blocking'
    options.add_argument 'no-sandbox'
    #options.add_argument 'remote-debugging-port=9222'
    #options.add_argument 'remote-debugging-address=0.0.0.0'
    Capybara::Selenium::Driver.new app, browser: :chrome, driver_path:chromeDriver_path, options: options
  end

elsif $ENVIRONMENT.eql?('LOCAL_PHANTOMJS')

  phantomJSDriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), 'webdrivers/mac', 'phantomjs')
  Capybara.ignore_hidden_elements = true
  Capybara.default_max_wait_time = 10
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
  Capybara.register_driver :poltergeist do |app|
    options = {
        :js_errors=> false,
        :window_size => [1280,2000],
        :debug => false,
        :phantomjs_options => ['--load-images=no', 'js_errors - false', '--disk-cache=false'],
        :inspector => true,
    }
    Capybara::Poltergeist::Driver.new(app, :phantomjs => phantomJSDriver_path, :js_errors=> false, :timeout=>10, :window_size => [1280,2000],
                                      :options => options, :url_whitelist=>['https://www.hepsiburada.com',
                                                                            'http://www.hepsiburada.com',
                                                                            'https://checkout.test.hepsiburada.com',
                                                                            'https://checkout.qa.hepsiburada.com',
                                                                            'http://checkout.test.hepsiburada.com',
                                                                            'http://checkout.qa.hepsiburada.com',
                                                                            'http://storefront.qa.hepsiburada.com',
                                                                            'https://www.hepsiburada.com/mc/giris',
                                                                            'https://images.hepsiburada.net',
                                                                            'https:-//images.hepsiburada.net',
                                                                            'http://images.hepsiburada.net',
                                                                            'https://static.hepsiburada.net',
                                                                            'http://static.hepsiburada.net',
                                                                            'http://design.hepsiburada.net',
                                                                            'https://design.hepsiburada.net',
                                                                            'http://hepsiburadacdn.api.sociaplus.com',
                                                                            'https://spos.isbank.com.tr',
                                                                            'http://hbadmin.qa.hepsiburada.com',
                                                                            'https://hbadmin.qa.hepsiburada.com',
                                                                            'https://hbadmin.hepsiburada.com',
                                                                            'http://hbadmin.hepsiburada.com',
                                                                            'https://merchantservice.hepsiburada.com',
                                                                            'https://pim-internal.hepsiburada.com',
                                                                            'https://oms.hepsiburada.com',
                                                                            'https://oms-internal.hepsiburada.com',
                                                                            'http://omshb.qa.hepsiburada.com' ])
  end
elsif $ENVIRONMENT.eql?('REMOTE_DOCKER')
  Phantomjs.path
  Capybara.default_driver = :poltergeist
  Capybara.ignore_hidden_elements = true
  Capybara.default_max_wait_time = 120
  Capybara.javascript_driver = :poltergeist
  Capybara.register_driver :poltergeist do |app|
    options = {
        :js_errors => false,
        :debug => false,
        :phantomjs_options => [ '--ignore-ssl-errors=yes','--load-images=no','--ssl-protocol=TLSv1'],
        :inspector => false
    }
    Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path, :js_errors=> false, :timeout=>120, :window_size => [1280,2000],
                                      :options => options, :url_whitelist=>['https://www.hepsiburada.com',
                                                                            'http://www.hepsiburada.com',
                                                                            'https://checkout.test.hepsiburada.com',
                                                                            'http://checkout.test.hepsiburada.com',
                                                                            'http://storefront.qa.hepsiburada.com',
                                                                            'https://www.hepsiburada.com/mc/giris',
                                                                            'https://images.hepsiburada.net',
                                                                            'http://images.hepsiburada.net',
                                                                            'https://static.hepsiburada.net',
                                                                            'http://static.hepsiburada.net',
                                                                            'http://design.hepsiburada.net',
                                                                            'https://design.hepsiburada.net',
                                                                            'http://hepsiburadacdn.api.sociaplus.com',
                                                                            'https://spos.isbank.com.tr',
                                                                            'http://hbadmin.qa.hepsiburada.com',
                                                                            'https://hbadmin.qa.hepsiburada.com',
                                                                            'https://hbadmin.hepsiburada.com',
                                                                            'http://hbadmin.hepsiburada.com',
                                                                            'https://merchantservice.hepsiburada.com',
                                                                            'https://pim-internal.hepsiburada.com',
                                                                            'https://oms.hepsiburada.com',
                                                                            'https://oms-internal.hepsiburada.com',
                                                                            'http://omshb.qa.hepsiburada.com' ])

  end

end

