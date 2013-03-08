# Contains application-wide view helper methods.
module ApplicationHelper
  # Returns the brand name wrapped in a span
  def brand
    result = content_tag(:span, "Tyne", :class => "brand-name")
    result.html_safe
  end

  # Builds a localised page title.
  def page_title
    options = {}
    options[:key] = @project.key if @project
    options[:user] = current_user.username if current_user
    options[:user] = @user.username if @user
    options[:user] = @project.user.username if @project
    options[:number] = @issue.number if @issue

    title = I18n.t("titles.#{controller.controller_name}.#{params[:action]}", options)

    "#{title} - Tyne"
  end

  # Converts the given markup into html.
  #
  # @param [String] markup
  def markup_to_html(markup)
    @markdown ||= Redcarpet::Markdown.new(MdEmoji::Render, :autolink => true, :space_after_headers => true, :no_intra_emphasis => true)

    markup = MarkdownPreprocessors::IssueAutoLink.new.process(markup, @project)
    @markdown.render(markup).html_safe
  end

  # Alias for the issue path as scoped under user and project.
  def path_to_issue(issue)
    main_app.issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.number)
  end
end
