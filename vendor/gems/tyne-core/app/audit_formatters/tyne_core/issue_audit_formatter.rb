module TyneCore
  # Formats an issue audit
  class IssueAuditFormatter < AuditFormatter::Base
    include TyneCore::AvatarHelper

    # Formats an issue audit into a human readable format.
    def format
      try(object.action)
    end

    def icon
      image_tag "icon-sweets/32/#{icon_name}"
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
        options[:assignee] = TyneAuth::User.find(object.audited_changes["assigned_to_id"].last).username
        return t("#{lookup}.assigned_to_id_html", options).html_safe
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
      link_to "#{issue.key} - #{issue.summary}", issue_path(:user => project.user.username, :key => project.key, :id => issue.number)
    end

    def project_link
      link_to project.name, backlog_path(:user => project.user.username, :key => project.key)
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
end
