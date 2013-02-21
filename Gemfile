source 'https://rubygems.org'

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
end

gem "jquery-rails", '~> 2.1.0'
gem 'compass-rails'

gem "simple_form"
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem "mousetrap-rails"
gem "redcarpet"
gem "md_emoji"
gem "best_in_place", :path => 'vendor/gems/best_in_place'

# Tyne
gem 'tyne_ui', :path => 'vendor/gems/tyne-ui'
gem 'tyne_core', :git => 'https://github.com/tyne/tyne-core.git', :branch => 'master'
gem 'tyne_auth', :git => 'https://github.com/tyne/tyne-auth.git', :branch => 'master'

gem 'modernizr-rails'
gem 'twitter-bootstrap-rails'
gem "less-rails"

gem "i18n-js"

# Webserver
gem 'thin'

# Assets
gem "asset_sync"

group :production do
 gem 'pg'
 gem 'unicorn'
 gem 'newrelic_rpm'
 gem 'dalli'
end

# Testing
group :test, :development do
  gem "sqlite3"
  gem "rspec-rails"
  gem "capybara"
end
