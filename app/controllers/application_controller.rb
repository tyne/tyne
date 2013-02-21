class ApplicationController < ActionController::Base

  helper :"tyne_core/avatar"

  protect_from_forgery

  helper_method :current_user, :admin_area?
  before_filter :add_breadcrumb_root

  # Returns the current user if user is logged in or nil.
  #
  # @return TyneAuth::User
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  private
  def require_login
    unless current_user
      redirect_to(main_app.login_path)
    end
  end

  def add_breadcrumb_root
    add_breadcrumb "Dashboard", main_app.root_path if current_user
  end
end
