require "tyne_auth/extensions/action_controller"

module TyneAuth
  # Contains global extensions
  module Extensions
  end
end

ActionController::Base.send(:include, TyneAuth::Extensions::ActionController)
