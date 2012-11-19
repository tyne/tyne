module ApplicationHelper
  def brand
    result = content_tag(:span, "Tyne", :class => "brand-name")
    result.html_safe
  end

  def project_name
    content_tag :span, "#{@project.user.username}/#{@project.key}", :class => "brand-project" if @project
  end

  def avatar_url(user, options={})
    opt = {:width => 48}.merge(options)

    default_url = "#{main_app.root_url}assets/guest.png"
    if user.gravatar_id
      "http://gravatar.com/avatar/#{user.gravatar_id}.png?s=#{opt[:width]}&d=#{CGI.escape(default_url)}"
    else
      default_url
    end
  end

  def avatar(user)
    image_tag avatar_url(user, { :width => 24 }), :class => 'avatar', :width => 24
  end

  def breadcrumb
    project = @project && @project.persisted?
    issue = @issue && @issue.persisted?
    user = @user && @user.persisted? ? @user : current_user

    user_link = link_to(user.username, main_app.overview_path(:user => user.username))

    project_link = link_to(@project.name, main_app.backlog_path(:user => user.username, :key => @project.key)) if project
    issue_link = link_to(@issue.summary, main_app.issue_path(:user => user.username, :key => @project.key, :id => @issue.number)) if issue
    admin_link = link_to("Administration", tyne_core.projects_path) if admin_area?

    content = breadcrumb_link(user_link, project || admin_area?)
    content << breadcrumb_link(admin_link, false) if admin_area?
    content << breadcrumb_link(project_link, issue) if project
    content << breadcrumb_link(issue_link, false) if issue

    content_tag :ul, content, :class => "breadcrumb"
  end

  private
  def breadcrumb_link(content, add_divider = false)
    divider = content_tag :span, '/', :class => 'divider'

    content << divider if add_divider

    content_tag :li, content
  end
end
