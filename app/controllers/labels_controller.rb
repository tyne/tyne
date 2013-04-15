# Handles requests for labels
class LabelsController < ApplicationController
  self.responder = ::ApplicationResponder
  respond_to :html, :json

  before_filter :load_user
  before_filter :load_project
  before_filter :require_login
  before_filter :ensure_can_collaborate

  # Creates a new label for a project
  def create
    @label = @project.labels.build(params[:label])
    @label.save

    respond_with(@label) do |format|
      format.pjax { render @label }
    end
  end
end
