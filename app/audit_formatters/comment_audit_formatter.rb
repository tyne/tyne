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
    format_context.image_tag "icon-sweets/32/comments.png"
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
    LinkHelper.new(format_context).issue_link(issue)
  end

  def project_link
    LinkHelper.new(format_context).project_link(project)
  end
end
