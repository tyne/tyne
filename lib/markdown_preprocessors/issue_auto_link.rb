module MarkdownPreprocessors
  class IssueAutoLink
    include Rails.application.routes.url_helpers

    INTERNAL_MATCHER = /#(\d+)/
    PROJECT_WIDE_MATCHER = /#([a-zA-Z_-]+)\-(\d+)/

    def process(text, project)
      text.gsub PROJECT_WIDE_MATCHER do |match|
        key = $1
        number = $2

        project = Project.find_by_key(key)

        return match unless project
        return match unless issue_exists?(project, number)

        url = link_path(project, number)
        return "[##{number}](#{url})"
      end

      text.gsub INTERNAL_MATCHER do |match|
        number = $1

        return match unless issue_exists?(project, number)

        url = link_path(project, number)
        return "[##{number}](#{url})"
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
