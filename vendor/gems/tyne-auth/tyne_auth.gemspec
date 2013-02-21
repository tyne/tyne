$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tyne_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tyne_auth"
  s.version     = TyneAuth::VERSION
  s.authors     = ["Tobias Haar"]
  s.email       = ["tobias.haar@googlemail.com"]
  s.homepage    = "http://www.tobiashaar.de"
  s.summary     = "Provides authorisation and authentication logic for tyne."
  s.description = "Provides authorisation and authentication logic for tyne."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-github"
  s.add_dependency "octokit"
  s.add_dependency "twitter-bootstrap-rails"

  s.add_development_dependency "sqlite3"
end
