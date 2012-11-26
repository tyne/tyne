module BreadcrumbHelper
  def breadcrumb
    user = @user && @user.persisted? ? @user : current_user
    project = @project && @project.persisted? ? @project : nil
    issue = @issue && @issue.persisted? ? @issue : nil

    entries = collect_breadcrumb_entries(user, project, issue)

    build_breadcrumb(entries)
  end

  private

  def build_breadcrumb(entries)
    content = []

    entries.each_with_index do |entry, i|
      content << content_tag(:li, link_to(entry[:text], entry[:path]))
      content << content_tag(:span, '/', :class => 'divider') if i < entries.size - 1
    end

    content_tag :ul, content.join.html_safe, :class => 'breadcrumb'
  end

  def collect_breadcrumb_entries(user, project, issue)
    entries = []

    entries << {
      :text => user.username,
      :path => main_app.overview_path(:user => user.username)
    }

    entries << {
      :text => project.name,
      :path => main_app.backlog_path(:user => user.username, :key => project.key)
    } if project

    entries << {
      :text => issue.key,
      :path => main_app.issue_path(:user => user.username, :key => project.key, :id => issue.number)
    } if issue

    entries << {
      :text => 'Administration',
      :path => tyne_core.projects_path
    } if admin_area?

    entries
  end
end
