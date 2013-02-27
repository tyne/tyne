# Formats an issue audit
class IssueAuditFormatter < AuditFormatter::Base
  include AvatarHelper

  # Formats an issue audit into a human readable format.
  def format
    try(object.action)
  end

  def icon
    format_context.image_tag "icon-sweets/32/#{icon_name}"
  end

  def details
    return issue.description if create?
  end

  # Returns a formatted message for a new issue
  def create
    defaults = []
    message = "#{i18n_base_scope}.create.#{issue.issue_type.name.underscore}_html"

    defaults << :"#{i18n_base_scope}.create.default_html"

    return t(message, :user => user_link, :issue => issue_link, :project => project_link, :default => defaults).html_safe
  end

  # Returns a formatted message for an updated issue
  def update
    lookup = "#{i18n_base_scope}.update"
    options = { :user => user_link, :issue => issue_link, :project => project_link }

    if assignee_changed?
      new_assignee = object.audited_changes["assigned_to_id"].last

      if new_assignee
        options[:assignee] = User.find(new_assignee).username
        return t("#{lookup}.assigned_to_id_html", options).html_safe
      end
    end

    return t("#{lookup}.state.#{object.audited_changes["state"].last}_html", options).html_safe if workflow_state_changed?

    t("#{lookup}.default_html", options).html_safe
  end

  private
  def issue
    @issue ||= object.auditable
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

  def icon_name
    return "issue-created.png" if create?
    return "issue-updated.png" if update?
  end

  def assignee_changed?
    object.audited_changes.include?("assigned_to_id")
  end

  def workflow_state_changed?
    object.audited_changes.include?("state")
  end
end
