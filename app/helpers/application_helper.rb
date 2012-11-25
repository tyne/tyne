module ApplicationHelper
  def brand
    result = content_tag(:span, "Tyne", :class => "brand-name")
    result.html_safe
  end

  def project_name
    content_tag :span, "#{@project.user.username}/#{@project.key}", :class => "brand-project" if @project
  end
end
