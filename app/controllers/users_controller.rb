# Handles requests for user specific tasks
class UsersController < ApplicationController
  self.responder = ::ApplicationResponder
  respond_to :html, :json

  before_filter :load_user
  before_filter :require_login, :only => [:edit, :update]

  # Displays an overview page with user information and the list
  # of public projects.
  def overview
    @projects = @user.projects.privacy_public
  end

  # Displays the account settings page where the user
  # can edit its details.
  def edit
    @account = current_user
  end

  # Updates the current_user's details.
  def update
    @user = current_user
    @user.update_attributes(params[:account])

    respond_with(@user, :location => edit_account_settings_path(:user => @user.username))
  end
end
