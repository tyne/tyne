require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests for reports
  class ReportsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json, :pjax

    before_filter :require_login
    before_filter :load_user
    before_filter :load_project
    before_filter :ensure_can_collaborate

    # Displays the list of all available reports (e.g. Issue Type Ratio)
    def index
      add_breadcrumb :index
    end

    # Displays the issue type ratio report
    def issue_type_ratio
      add_breadcrumb :index, main_app.reports_path(:user => @user.username, :key => @project.key)
      add_breadcrumb :issue_type_ratio

      report = TyneCore::Reports::IssueTypeRatio.new(@project)
      @chart = report.to_chart
    end
  end
end
