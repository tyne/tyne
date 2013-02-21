$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tyne_ui/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tyne_ui"
  s.version     = TyneUi::VERSION
  s.authors     = ["Tobias Haar"]
  s.email       = ["tobias.haar@gmail.com"]
  s.homepage    = "http://www.tobiashaar.de"
  s.summary     = "Assets for Tyne."
  s.description = "Assets for Tyne."

  s.files = Dir["{lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '~> 3.2.8'
  s.add_dependency 'sass-rails'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'compass-rails'
  s.add_dependency 'twitter-bootstrap-rails'
  s.add_dependency 'cells'
  s.add_dependency 'smt_rails'
  s.add_dependency 'simple_form'
  s.add_dependency "google_visualr", ">= 2.1"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "evergreen"
end
