# Handles requests for labels
class LabelsController < ApplicationController
  self.responder = ::ApplicationResponder
  respond_to :html, :json

  before_filter :load_label_project
  before_filter :require_login
  before_filter :ensure_can_collaborate

  # Creates a new label for a project
  def create
    @label = @project.labels.build(params[:label])
    @label.save

    respond_with(@label) do |format|
      format.pjax { render @label, :locals => { :issue => nil } }
    end
  end

  # Deletes a label for a project
  def destroy
    @label = @project.labels.find_by_id(params[:id])

    @label.destroy
    respond_with(@label) do |format|
      format.js { render {} }
    end
  end

  private
  def load_label_project
    @project = Project.find_by_id(params[:project_id])
    @user = @project.user
  end
end
