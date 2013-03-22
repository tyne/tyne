config_hash = YAML.load_file("#{Rails.root}/config/tyne.yml")[Rails.env]

APP_CONFIG = Hashie::Mash.new(config_hash)
