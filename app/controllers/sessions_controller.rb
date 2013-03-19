# Handles requests to create and destroy sessions (e.g. login, logout)
class SessionsController < ApplicationController
  before_filter :require_login, :only => [:destroy]

  # Tries to login user with provided details or creates a new user
  # It redirects to the root page
  def create
    auth_hash = request.env['omniauth.auth']

    user = AuthProcessor.new(auth_hash).find_or_create_user
    session[:user_id] = user.id

    redirect_to redirect_url_for_login, :notice => I18n.t("authentication.logged_in", :username => user.name)
  end

  # Logout the user
  # Redirects to the login page
  def destroy
    session[:user_id] = nil
    redirect_to login_path, :notice => I18n.t("authentication.logged_out")
  end

  # Displays an error message and redirect to the login page
  def failure
    flash[:error] = I18n.t("authentication.not_allowed")

    redirect_to login_path
  end

  private
  def redirect_url_for_login
    params_hash = (request.env['omniauth.params'] || {})
    params_hash["redirect_url"] || root_path
  end
end
