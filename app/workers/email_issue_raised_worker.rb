class EmailIssueRaisedWorker
  include Sidekiq::Worker

  def perform(issue_id)
    issue = Issue.find_by_id(issue_id)
    IssueMailer.send_issue_raised(issue) if issue
  end
end
