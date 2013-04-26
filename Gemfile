source 'https://api.rubygems.org'

gem 'rails', '~> 3.2.13'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'libv8', '~> 3.11.8'
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'turbo-sprockets-rails3'
end

gem 'sass-rails',   '~> 3.2.3'
gem 'compass-rails'
gem "jquery-rails", '~> 2.2.0'
gem 'jquery-cookie-rails'

gem "simple_form"
gem 'client_side_validations', :git => "https://github.com/bcardarella/client_side_validations.git", :branch => "3-2-stable"
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
gem 'spectrum-rails'
gem 'exception_notification'

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
gem "rvm-capistrano"
gem "sidekiq"
gem "foreman"

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
  gem "guard-rspec"
  gem 'rb-fsevent', '~> 0.9'
  gem "jasminerice"
  gem "yard"
  gem 'coveralls', :require => false
end
