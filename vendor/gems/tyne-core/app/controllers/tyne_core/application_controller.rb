# Application controller for core engine.
class TyneCore::ApplicationController < ApplicationController
  private
  def load_user
    @user = TyneAuth::User.find_by_username(params[:user])

    add_breadcrumb @user.username, main_app.overview_path(:user => params[:user])
  end

  def load_project
    @project = TyneCore::Project.joins(:user).where(:key => params[:key]).where(:tyne_auth_users => {:username => params[:user]  }).first

    add_breadcrumb @project.name, main_app.backlog_path(:user => params[:user], :key => params[:key])
  end

  def load_issue
    @issue = @project.issues.find_by_number(params[:id])

    add_breadcrumb @issue.key, main_app.issue_path(:user => params[:user], :key => params[:key], :id => params[:id])
  end

  def is_admin_area?
    false
  end
  helper_method :is_admin_area?

  def require_owner
    redirect_to main_app.root_path unless is_owner?
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
    redirect_to main_app.root_path unless is_collaborator?
  end
end
