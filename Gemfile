source 'https://api.rubygems.org'

gem 'rails', '~> 3.2.8'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'libv8', '~> 3.11.8'
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
  gem 'jquery-cookie-rails'
end

gem "jquery-rails", '~> 2.1.0'
gem 'compass-rails'

gem "simple_form"
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem "mousetrap-rails"
gem "redcarpet"
gem "md_emoji"
gem "cells"
gem "smt_rails"
gem "audited-activerecord"
gem "responders"
gem "state_machine"
gem "acts_as_list"
gem "google_visualr"
gem 'twitter-bootstrap-rails-confirm', :git => 'https://github.com/bluerail/twitter-bootstrap-rails-confirm.git'

# Tyne
gem "best_in_place", :path => 'vendor/gems/best_in_place'

gem 'modernizr-rails'
gem 'twitter-bootstrap-rails'
gem "less-rails"

gem "i18n-js"

# Webserver
gem 'thin'

# Assets
gem "asset_sync"

gem "omniauth"
gem "omniauth-github"
gem "octokit"

group :production do
 gem 'pg'
 gem 'newrelic_rpm'
 gem 'dalli'
end

# Testing
group :test, :development do
  gem "sqlite3"
  gem "rspec-rails"
  gem "capybara"
  gem "shoulda-matchers"
  gem "rspec-cells"
  gem "pry"
  gem "factory_girl_rails"
  gem "guard-jasmine"
  gem "jasminerice"
  gem "yard"
  gem "simplecov"
end
