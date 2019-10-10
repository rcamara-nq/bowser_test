# frozen_string_literal: true

module BowserAutomator
  require 'selenium/webdriver'
  require 'yaml'
  require_relative './error/no_google_page_error'

  class Automator
    def initialize(plugin_version = 'chrome-staging-1.3.crx')
      load_config

      options = Selenium::WebDriver::Chrome::Options.new
      options.add_extension(File.join(BowserAutomator.root,
                                      'data', plugin_version))
      @driver = Selenium::WebDriver.for :chrome, options: options
    end

    def authenticate_steps
      login_button
      set_pincode
      #accept_agreements
      select_ok_device
      configure_ok_device
      connect_with_extension
    end

    def run
      authenticate_steps
      yield
    end

    def open_new_tab(url = '')
      sleep 1
      @driver.execute_script('window.open()')
      @driver.switch_to.window(@driver.window_handles.last)
      @driver.get url
      sleep 0.5
    end

    def search_in_google(term = '')
      unless @driver.current_url.include? 'google.com'
        raise NoGooglePageError, 'Could not search in Google because' \
' current page is not Google Search page'
      end

      sleep 1
      @driver.find_element(:css, 'input.gLFyf.gsfi').send_keys term
      sleep 0.5
      @driver.find_element(:css, 'input[value="Google Search"]').click
      sleep 2
      @driver.find_element(:css, '#search .g:nth-of-type(1) a').click
    end

    def switch_to_window(index = 0)
      @driver.switch_to.window @driver.window_handles[index]
    end

    def execute_script(script)
      @driver.execute_script script
    end

    def quit
      @driver.quit
    end

    private

    def load_config
      @config = YAML.load_file File.join(BowserAutomator.root,
                                         'config', 'test_config.yml')
    end

    def login_button
      @driver.get @config['steps_info']['setup_url']
      @driver.find_element(:css, '.action_button_wrapper a').click
      sleep 1
    end

    def set_pincode
      @driver.find_element(:css, '.user_session_pincode input')
             .send_keys @config['steps_info']['pincode']
      @driver.find_element(:css, '.btn-action.btn-login-submit').click
      sleep 1
    end

    def accept_agreements
      @driver.find_element(:css, '#accept').click
      @driver.find_element(:css, '#privacy_accept').click
      @driver.find_element(:css, '.btn-action').click
    end

    def select_ok_device
      @driver.find_element(:css, 'li.ok a.btn-info').click
      sleep 1
    end

    def configure_ok_device
      @driver.find_element(:css,
                           '.col-xs-12.ok .btn-action:nth-of-type(1)')
             .click
      sleep 1
    end

    def connect_with_extension
      @driver.find_element(:css, '.col-xs-6.next input').click
    end
  end
end
