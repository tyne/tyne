require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../spec/dummy/config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'rspec/cells'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

Dir[File.expand_path("../../spec/support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end
