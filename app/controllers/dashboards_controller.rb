# Handles all requests for dashboards
class DashboardsController < ApplicationController
  self.responder = ::ApplicationResponder
  respond_to :html, :json

  before_filter :require_login

  # Displays the index view with the default dashboard
  def index
    @accessible_projects = current_user.accessible_projects
    @most_active_projects = Project.most_active(5)
    @audits = Audited::Adapters::ActiveRecord::Audit.unscoped.
      where(:associated_id => @accessible_projects.map { |x| x.id }, :associated_type => Project.name).
      where("action <> ?", "update").
      order("created_at DESC").
      limit(25)
  end
end
