# Application controller for core engine.
class ApplicationController < ActionController::Base
  helper_method :current_user, :admin_area?
  before_filter :add_breadcrumb_root

  # Returns the current user if user is logged in or nil.
  #
  # @return User
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  private
  def require_login
    unless current_user
      redirect_to(login_path(:redirect_url => request.path))
    end
  end

  def add_breadcrumb_root
    add_breadcrumb "Dashboard", root_path if current_user
  end

  def load_user
    @user = User.find_by_username(params[:user])

    add_breadcrumb @user.username, overview_path(:user => params[:user])
  end

  def load_project
    @project = Project.joins(:user).where(:key => params[:key]).where(:users => {:username => params[:user]  }).first

    add_breadcrumb @project.name, backlog_path(:user => params[:user], :key => params[:key])
  end

  def load_issue
    @issue = @project.issues.find_by_number(params[:id])

    add_breadcrumb @issue.key, issue_path(:user => params[:user], :key => params[:key], :id => params[:id])
  end

  def is_admin_area?
    false
  end
  helper_method :is_admin_area?

  def require_owner
    redirect_to root_path unless is_owner?
  end

  def is_owner?
    return false unless @project
    @project.owners.map { |x| x.user }.include? current_user
  end
  helper_method :is_owner?

  def is_collaborator?
    return false unless @project

    users = @project.workers.uniq { |x| x.user_id }.map { |x| x.user }
    users.include?(current_user)
  end
  helper_method :is_collaborator?

  def ensure_can_collaborate
    redirect_to root_path unless is_collaborator?
  end
end
