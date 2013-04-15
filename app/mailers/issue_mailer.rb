# Mailer for issues
class IssueMailer < ActionMailer::Base
  default :from => "'Tyne' <notifications@tyne-tickets.org>"

  # Sends a notification to all contributors
  # that a new issue has been raised.
  def self.send_issue_raised(issue_id)
    issue = Issue.find_by_id(issue_id)
    issue.project.workers.each do |team_member|
      delay.issue_raised(issue_id, team_member.id) unless is_reporter?(team_member, issue)
    end
  end

  # Sends a notification that a new issue has been raised.
  def issue_raised(issue_id, team_member_id)
    @issue = Issue.find_by_id(issue_id)
    @worker = TeamMember.find_by_id(team_member_id)

    return unless @issue
    return unless @worker

    to = @worker.user.notification_email

    mail(:to => to, :subject => "[Raised] #{@issue.key} - #{@issue.summary}") if to
  end

  # Sends a notification to the reporter of the issue
  # that the issue has been closed.
  def issue_closed(issue_id)
    issue_state_changed("Closed", issue_id, :reported_by)
  end

  # Sends a notification to the assignee
  # that the issue has been reopened.
  def issue_reopened(issue_id)
    issue_state_changed("Reopened", issue_id, :assigned_to)
  end

  private
  def self.is_reporter?(worker, issue)
    worker.user_id == issue.reported_by.id
  end

  def issue_state_changed(state, issue_id, to)
    @issue = Issue.find_by_id(issue_id)

    # Send to reporter
    if @issue.respond_to?(to) && @issue.public_send(to)
      to = @issue.public_send(to).notification_email
      mail(:to => to, :subject => "[#{state}] #{@issue.key} - #{@issue.summary}") if to
    end
  end
end
