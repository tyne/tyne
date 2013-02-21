source "http://rubygems.org"

gemspec

gem "jquery-rails"

gem "active_model_serializers", :git => "https://github.com/rails-api/active_model_serializers.git"

# Webserver
gem 'thin'

group :production do
 gem 'pg'
end

# Testing
group :test, :development do
  gem 'tyne_dev', :git => "https://github.com/tyne/tyne-dev.git", :branch => "master"
  gem 'rb-inotify'
end
