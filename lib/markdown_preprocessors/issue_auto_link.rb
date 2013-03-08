module MarkdownPreprocessors
  # Create links between issues.
  #
  # #1      => [#1](issue/path)
  # #FOO-1  => [#FOO-1](issue/path)
  class IssueAutoLink
    include Rails.application.routes.url_helpers

    # Matcher for issue links inside a project like #1 and #2
    INTERNAL_MATCHER = /#(\d+)/

    # Matcher for project wide issue links such as #FOO-1
    PROJECT_WIDE_MATCHER = /#([a-zA-Z_-]+)\-(\d+)/

    # Processes the given markup.
    # Matched text gets converted into hyperlinks.
    def process(text, project)
      text.gsub! PROJECT_WIDE_MATCHER do |match|
        key = $1
        number = $2

        project = Project.find_by_key(key)

        if project && issue_exists?(project, number)
          url = link_path(project, number)
          "[##{key}-#{number}](#{url})"
        else
          match
        end
      end

      text.gsub INTERNAL_MATCHER do |match|
        number = $1

        if issue_exists?(project, number)
          url = link_path(project, number)
          "[##{number}](#{url})"
        else
          match
        end
      end
    end

    private

    def issue_exists?(project, number)
      project.issues.exists?(:number => number)
    end

    def link_path(project, number)
      issue_path(:user => project.user.username, :key => project.key, :id => number)
    end
  end
end
