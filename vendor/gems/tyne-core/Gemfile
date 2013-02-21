source "http://rubygems.org"

gemspec

gem "jquery-rails"
gem 'execjs'
gem 'therubyracer'
gem 'sass-rails'
gem 'compass-rails'

gem 'responders'
gem "simple_form"
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

# Tyne
gem 'tyne_auth', :git => 'https://github.com/tyne/tyne-auth.git', :branch => 'master'
gem 'tyne_ui', :git => 'https://github.com/tyne/tyne-ui.git', :branch => 'master'

gem 'modernizr-rails'
gem "mousetrap-rails"
gem 'twitter-bootstrap-rails'
gem "redcarpet"
gem "md_emoji"
gem "best_in_place", :git => 'https://github.com/tyne/best_in_place.git'
gem 'evergreen', :require => 'evergreen/rails'

# Webserver
gem 'thin'

group :production do
 gem 'pg'
end

# Testing
group :test, :development do
  gem 'tyne_dev', :git => 'https://github.com/tyne/tyne-dev.git', :branch => 'master'
  gem 'rb-inotify', '~> 0.8.8'
  gem 'shoulda-matchers'
  gem 'poltergeist'
end
