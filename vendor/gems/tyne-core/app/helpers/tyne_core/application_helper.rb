module TyneCore
  # Provides global view helpers for the core engine.
  module ApplicationHelper
    # Creates a simple form with disabled form elements
    # def disabled_form_for(object, *args, &block)
    #   options = args.extract_options!
    #   simple_form_for(object, *(args << options.merge(:builder => TyneCore::FormBuilder::DisabledFormBuilder)), &block)
    # end
    def markup_to_html(markup)
      markdown = Redcarpet::Markdown.new(MdEmoji::Render, :autolink => true, :space_after_headers => true, :no_intra_emphasis => true)
      markdown.render(markup).html_safe
    end

    # Alias for the issue path as scoped under user and project.
    def path_to_issue(issue)
      main_app.issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.number)
    end
  end
end
