# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

def sign_in_as(user)
  visit new_user_session_path
  fill_in 'Login', with: "#{user.username}"
  fill_in 'Password', with: 'password'
  click_on 'Log in'
end

def fill_in_order
  fill_in 'Cat number', with: 'ABC123'
  fill_in 'Product name', with: 'Test Product'
  fill_in 'Quantity', with: '2'
  fill_in 'Price', with: '15.25'
  fill_in 'URL', with: 'http://www.google.com'
  click_on 'Add Item'
end
