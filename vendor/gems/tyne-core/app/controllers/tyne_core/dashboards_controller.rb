require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles all requests for dashboards
  class DashboardsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :require_login

    # Displays the index view with the default dashboard
    def index
      @accessible_projects = current_user.accessible_projects
      @most_active_projects = TyneCore::Project.order("updated_at DESC").limit(5)
      @audits = Audited::Adapters::ActiveRecord::Audit.unscoped.where(:associated_id => [@accessible_projects.map { |x| x.id }], :associated_type => TyneCore::Project.name).order("created_at DESC").limit(25)
    end
  end
end
