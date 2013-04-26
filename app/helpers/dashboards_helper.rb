# View helper for dashboard
module DashboardsHelper
  # Renders the font icon depending on the project privacy state
  # @param [Project] project
  def project_icon(project)
    klass = ["icon"]
    klass << if project.privacy
              "icon-lock"
            else
              ["mini-icon", "mini-icon-public"]
            end
    content_tag :span, "", :class => klass.join(' ')
  end

  # Renders a badge with the number of open issues
  # @param [Project] project
  def issue_number(project)
    content_tag :span, project.issues.not_completed.count, :class => "issue-count badge"
  end
end
