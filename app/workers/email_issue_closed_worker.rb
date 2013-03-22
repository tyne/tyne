class EmailIssueClosedWorker
  include Sidekiq::Worker

  def perform(issue_id)
    issue = Issue.find_by_id(issue_id)
    IssueMailer.issue_closed(issue).deliver if issue
  end
end
