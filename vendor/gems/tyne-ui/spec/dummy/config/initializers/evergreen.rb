if Rails.env.test?
  require 'capybara/poltergeist'
  require "evergreen"
  Evergreen.configure do |c|
    c.driver = :poltergeist
  end
end
