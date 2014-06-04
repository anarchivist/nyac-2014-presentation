#! /usr/bin/env ruby

# screenshot.rb
# screenshot.rb http://url filename.png

require 'capybara/dsl'
require 'capybara-webkit'
# require 'capybara/poltergeist'
require 'fileutils'
include Capybara::DSL

url = ARGV[0] || (puts "You must enter the base URL followed by the filename."; exit)
filename = ARGV[1] || 'screenshot'

# temporary file for screenshot
FileUtils.mkdir('./screenshots') unless File.exist?('./screenshots')

Capybara.configure do |config|
  config.run_server = false
  config.default_driver
  config.current_driver = :webkit # :poltergeist
  config.app = "fake app name"
  config.app_host = url
end

visit url # visit the first page

# change the size of the window
if Capybara.current_driver == :webkit
  page.driver.resize_window(1024,768)
end

sleep 3 # Allow the page to render correctly
fn = "./screenshots/" + filename + ".png"
page.save_screenshot(fn, width: 1024, height: 768) # take screenshot of first page
