# Handles requests for project creation, updates, deletions
class ProjectsController < ApplicationController
  self.responder = ::ApplicationResponder
  respond_to :html, :json
  helper :teams

  before_filter :load_user, :only => [:admin]
  before_filter :load_project, :only => [:admin]
  before_filter :require_login
  before_filter :prepare_breadcrumb, :only => [:admin]
  before_filter :load_owned_project, :only => [:update, :destroy]
  before_filter :require_owner, :only => [:update, :destroy, :admin]

  # Renders a view to create a new project
  def new
    add_breadcrumb :new

    @project = current_user.projects.new
    respond_with(@project)
  end

  # Creates a new project.
  def create
    add_breadcrumb :new

    privacy = params[:project].delete(:privacy)

    @project = current_user.projects.new(params[:project])
    @project.privacy = privacy

    @project.save
    respond_with(@project, :location => backlog_path(:user => current_user.username, :key => @project.key))
  end

  # Upates an existing project.
  def update
    @project.update_attributes(params[:project])
    respond_with(@project, :location => admin_project_path(:user => @project.user.username, :key => @project.key))
  end

  # Destroys an existing project.
  def destroy
    @project.destroy
    respond_with(@project, :location => root_path)
  end

  # Renders a view to administer a project (Edit, Delete, Teams).
  def admin
    respond_with(@project)
  end

  def is_admin_area?
    action_name == "admin"
  end

  private
  def load_owned_project
    @project = current_user.owned_projects.find_by_id(params[:id])

    render_404 unless @project
  end

  def prepare_breadcrumb
    add_breadcrumb :admin, admin_project_path(:user => params[:user], :key => params[:key])
  end
end
