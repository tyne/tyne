class EmailIssueReopenedWorker
  include Sidekiq::Worker

  def perform(issue_id)
    issue = Issue.find_by_id(issue_id)
    IssueMailer.issue_reopened(issue).deliver if issue
  end
end
