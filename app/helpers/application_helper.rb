module ApplicationHelper
  def brand
    result = content_tag(:span, "Tyne", :class => "brand-name")
    result.html_safe
  end

  def project_name
    content_tag :span, "#{@project.user.username}/#{@project.key}", :class => "brand-project" if @project
  end

  def page_title
    title = if content_for?(:title)
      yield(:title)
    else
      options = {}
      options[:key] = @project.key if @project
      options[:user] = current_user.username if current_user
      options[:user] = @user.username if @user
      options[:user] = @project.user.username if @project
      options[:number] = @issue.number if @issue

      I18n.t("titles.#{controller.controller_name}.#{params[:action]}", options)
    end

    "#{title} - Tyne"
  end
end
