module TyneCore
  # Formats comment audits
  class CommentAuditFormatter < AuditFormatter::Base
    # Converts a comment audit into a user readable message
    #
    # @return [String] localised audit message as html
    def format
      message = "#{i18n_base_scope}.create_html"
      return t(message, :user => user_link, :issue => issue_link, :project => project_link)
    end

    def icon
      image_tag "icon-sweets/32/comments.png"
    end

    # Returns the comment message.
    def details
      comment.message
    end

    private
    def comment
      @comment ||= object.auditable
    end

    def issue
      @issue ||= comment.issue
    end

    def project
      @project ||= issue.project
    end

    def issue_link
      link_to "#{issue.key} - #{issue.summary}", issue_path(:user => project.user.username, :key => project.key, :id => issue.number)
    end

    def project_link
      link_to project.name, backlog_path(:user => project.user.username, :key => project.key)
    end
  end
end
