# Handles requests for reports
class ReportsController < ApplicationController
  self.responder = ::ApplicationResponder
  respond_to :html, :json, :pjax

  before_filter :load_user
  before_filter :load_project
  before_filter :require_login
  before_filter :ensure_can_collaborate
  before_filter :add_report_breadcrumb

  # Displays the list of all available reports (e.g. Issue Type Ratio)
  def index; end

  # Displays the issue type ratio report
  def issue_type_ratio
    add_breadcrumb :issue_type_ratio

    report = Reports::IssueTypeRatio.new(@project)
    @chart = report.to_chart
  end

  # Displays a burn down chart
  def burn_down
    add_breadcrumb :burn_down

    report = Reports::BurnDown.new(@project.current_sprint)
    @chart = report.to_chart
  end

  private

  def add_report_breadcrumb
    add_breadcrumb :index, reports_path(:user => @user.username, :key => @project.key)
  end
end
