require "spec_helper"

describe IssueMailer do
  let(:issue) { issues(:foo) }

  describe :issue_raised do
    it "adds a background process for every contributor but the reporter" do
      expect do
        IssueMailer.send_issue_raised(issue.id)
      end.to change(Sidekiq::Extensions::DelayedMailer.jobs, :size).by(1)
    end

    it "sends an email with the correct details" do
      mail = IssueMailer.issue_raised(issue.id, issue.project.workers.last.id)
      mail.subject.should == "[Raised] TYNE-1 - Foo"
      mail.to.should include "me@example.com"
    end
  end

  describe :issue_reopened do
    it "sends an email to the assignee" do
      Issue.any_instance.stub_chain(:assigned_to, :notification_email).and_return("foo@bar.com")
      mail = IssueMailer.issue_reopened(issue.id)
      mail.subject.should == "[Reopened] TYNE-1 - Foo"
      mail.to.should include "foo@bar.com"
    end

    it "does not send an email if issue was not assigned" do
      Issue.any_instance.stub(:assigned_to)
      mail = IssueMailer.issue_reopened(issue.id)

      mail.to.should be_nil
    end

    it "does not send an email if assignee has no notification email" do
      Issue.any_instance.stub_chain(:assigned_to, :notification_email)
      mail = IssueMailer.issue_reopened(issue.id)

      mail.to.should be_nil
    end
  end

  describe :issue_closed do
    it "sends an email to the reporter" do
      Issue.any_instance.stub_chain(:reported_by, :notification_email).and_return("baz@qux.com")
      mail = IssueMailer.issue_closed(issue.id)
      mail.subject.should == "[Closed] TYNE-1 - Foo"
      mail.to.should include "baz@qux.com"
    end

    it "does not send an email if reporter has no notification email" do
      Issue.any_instance.stub_chain(:reported_by, :notification_email)
      mail = IssueMailer.issue_closed(issue.id)

      mail.to.should be_nil
    end
  end
end
