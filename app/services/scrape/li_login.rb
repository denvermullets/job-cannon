module Scrape
  class LiLogin < Service
    attr_reader :driver

    def initialize
      @email = ENV.fetch('EMAIL')
      @password = ENV.fetch('PASSWORD')
      @driver = Selenium::WebDriver.for :chrome
      @domain = ENV.fetch('LI_DOMAIN')
      @start = ENV.fetch('START')
    end

    def call
      login
    end

    private

    def login
      @driver.navigate.to("#{@domain}/login")
      @driver.find_element(name: 'session_key').send_keys(@email)
      @driver.find_element(name: 'session_password').send_keys(@password)
      @driver.find_element(class_name: 'btn__primary--large').click

      # Add necessary waits or checks to ensure login is successful
      # wait = Selenium::WebDriver::Wait.new(timeout: 10)
      # wait.until { @driver.find_element(id: 'element_after_login') }
      Selenium::WebDriver::Wait.new(timeout: 10)
      driver.save_screenshot('./screenshots/screenshot_login.png')

      driver.navigate.to(@start)
      Selenium::WebDriver::Wait.new(timeout: 10)
      driver.save_screenshot('./screenshots/1.png')
      self
    end
  end
end
