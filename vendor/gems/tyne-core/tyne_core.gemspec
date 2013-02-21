$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tyne_core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tyne_core"
  s.version     = TyneCore::VERSION
  s.authors     = ["Tobias Haar"]
  s.email       = ["tobias.haar@gmail.com"]
  s.homepage    = "http://www.tobiashaar.de"
  s.summary     = "Core functionality for Tyne"
  s.description = "Core functionality for Tyne"

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "simple_form"
  s.add_dependency "client_side_validations"
  s.add_dependency "client_side_validations-simple_form"
  s.add_dependency "rack-pjax"
  s.add_dependency "state_machine"
  s.add_dependency "twitter-bootstrap-rails-confirm"
  s.add_dependency "audited-activerecord"
  s.add_dependency "acts_as_list"
  s.add_dependency "jquery-cookie-rails"
  s.add_dependency "responders"

  s.add_development_dependency "sqlite3"
end
