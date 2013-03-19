# Mailer for issues
class IssueMailer < ActionMailer::Base
  default :from => "'Tyne' <notifications@tyne-tickets.org>"

  # Sends a notification to all contributors
  # that a new issue has been raised.
  def self.send_issue_raised(issue)
    issue.project.workers.each do |worker|
      issue_raised(issue, worker).deliver
    end
  end

  # Sends a notification that a new issue has been raised.
  def issue_raised(issue, worker)
    @issue = issue
    @worker = worker
    to = worker.user.notification_email

    mail(:to => to, :subject => "[Raised] #{issue.key} - #{issue.summary}") if to
  end

  # Sends a notification to the reporter of the issue
  # that the issue has been closed.
  def issue_closed(issue)
    @issue = issue

    # Send to reporter
    if issue.reported_by
      to = issue.reported_by.notification_email
      mail(:to => to, :subject => "[Closed] #{issue.key} - #{issue.summary}") if to
    end
  end

  # Sends a notification to the assignee
  # that the issue has been reopened.
  def issue_reopened(issue)
    @issue = issue
    # Send to to assignee
    if issue.assigned_to
      to = issue.assigned_to.notification_email
      mail(:to => to, :subject => "[Reopened] #{issue.key} - #{issue.summary}") if to
    end
  end
end
