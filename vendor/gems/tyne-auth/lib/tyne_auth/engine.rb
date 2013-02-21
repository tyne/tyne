require "omniauth"
require "omniauth-github"
require "octokit"

module TyneAuth
  # Authentication engine
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework = :rspec
      g.integration_tool = :rspec
    end

    isolate_namespace TyneAuth

    initializer "tyne_auth.omniauth" do |app|
      app.middleware.use(OmniAuth::Builder) do
        provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
      end
    end
  end
end
