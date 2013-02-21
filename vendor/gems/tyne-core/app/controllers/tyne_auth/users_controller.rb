require_dependency "tyne_core/application_controller"

# TyneAuth extensions
module TyneAuth
  # Handles requests for user specific tasks
  class UsersController < TyneCore::ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_user

    # Displays an overview page with user information and the list
    # of public projects.
    def overview

    end
  end
end
