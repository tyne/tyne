class IssueMailer < ActionMailer::Base
  default from: "noreply@tyne-tickets.org"

  def self.send_issue_raised(issue)
    # Send to all contributors
    issue.project.workers.each do |worker|
      issue_raised(issue, worker).deliver
    end
  end

  def issue_raised(issue, worker)
    to = worker.user.notification_email

    mail(:to => to, :subject => "[Raised] #{issue.key} - #{issue.summary}") if to
  end

  def issue_closed(issue)
    # Send to reporter
    to = worker.reported_by.notification_email
    mail(:to => to, :subject => "[Closed] #{issue.key} - #{issue.summary}") if to
  end

  def issue_reopened(issue)
    # Send to to assignee
    to = worker.assigned_to.notification_email
    mail(:to => to, :subject => "[Reopened] #{issue.key} - #{issue.summary}") if to
  end
end
