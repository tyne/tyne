# Handles requests for comments
class CommentsController < ApplicationController
  self.responder = ::ApplicationResponder
  respond_to :html, :json

  before_filter :load_user
  before_filter :load_project
  before_filter :require_login

  # Creates a new comment for an issue
  def create
    load_issue
    @comment = @issue.comments.build(params[:comment]) do |c|
      c.user = current_user
    end
    @comment.save
    respond_with(@comment) do |format|
      format.pjax { render @comment }
    end
  end

  private
  def load_issue
    @issue = @project.issues.find_by_number(params[:issue_id])
  end
end
