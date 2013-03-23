# Mailer for issues
class IssueMailer < ActionMailer::Base
  default :from => "'Tyne' <notifications@tyne-tickets.org>"

  # Sends a notification to all contributors
  # that a new issue has been raised.
  def self.send_issue_raised(issue_id)
    issue = Issue.find_by_id(issue_id)
    issue.project.workers.each do |worker|
      delay.issue_raised(issue_id, worker.id)
    end
  end

  # Sends a notification that a new issue has been raised.
  def issue_raised(issue_id, worker_id)
    @issue = Issue.find_by_id(issue_id)
    @worker = TeamMember.find_by_id(worker_id)
    to = @worker.user.notification_email

    mail(:to => to, :subject => "[Raised] #{@issue.key} - #{@issue.summary}") if to
  end

  # Sends a notification to the reporter of the issue
  # that the issue has been closed.
  def issue_closed(issue_id)
    @issue = Issue.find_by_id(issue_id)

    # Send to reporter
    if @issue.reported_by
      to = @issue.reported_by.notification_email
      mail(:to => to, :subject => "[Closed] #{@issue.key} - #{@issue.summary}") if to
    end
  end

  # Sends a notification to the assignee
  # that the issue has been reopened.
  def issue_reopened(issue_id)
    @issue = Issue.find_by_id(issue_id)
    # Send to to assignee
    if @issue.assigned_to
      to = @issue.assigned_to.notification_email
      mail(:to => to, :subject => "[Reopened] #{@issue.key} - #{@issue.summary}") if to
    end
  end
end
