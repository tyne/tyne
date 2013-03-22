# Load the rails application
require File.expand_path('../application', __FILE__)

config_hash = YAML.load_file("#{Rails.root}/config/tyne.yml")[Rails.env]
APP_CONFIG = Hashie::Mash.new(config_hash)

# Initialize the rails application
Tyne::Application.initialize!
