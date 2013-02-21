require 'cells'
require 'simple_form'
require 'google_visualr'

module TyneUi
  # Engine class
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework = :rspec
      g.integration_tool = :rspec
    end

    require 'sass-rails'
    config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')

    # require cells
    Dir[File.expand_path('../../../app/cells', __FILE__) + '/**/*.rb'].each {|f| require f}

    # require extensions
    Dir[File.expand_path('../extensions', __FILE__) + '/**/*.rb'].each {|f| require f}

    isolate_namespace TyneUi
  end
end

require 'smt_rails'

SmtRails.configure do |config|
  config.template_base_path = TyneUi::Engine.root.join('vendor', 'assets', 'javascripts', 'tyne_ui', 'templates')
end
