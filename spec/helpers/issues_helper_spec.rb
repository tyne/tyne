require 'spec_helper'

describe IssuesHelper do
  let(:user) { User.new(:name => "Foo", :username => "Foo") }
  let(:issue) { Issue.new }

  describe :issue_type do
    it "should render a tag with the name of the reporter" do
      issue.stub_chain(:issue_type, :name).and_return("Bug")

      content = helper.issue_type(issue)
      content.should have_selector "span.tag"
      content.should have_content "Bug"

      content = helper.issue_type(issue, true)
      content.should have_content "B"
    end
  end

  describe :issue_priority do
    it "should render a tag with the name of the reporter" do
      issue.stub_chain(:issue_priority, :name).and_return("High")

      content = helper.issue_priority(issue)
      content.should have_selector "span.tag"
      content.should have_content "High"

      content = helper.issue_priority(issue, true)
      content.should have_content "H"
    end
  end

  describe :issue_reported_by do
    it "should render a tag with the name of the reporter" do
      issue.stub(:reported_by).and_return(user)

      content = helper.issue_reported_by(issue)
      content.should have_selector "span.tag"
      content.should have_content user.name
    end
  end

  describe :issue_state do
    it "should render a tag with the current state" do
      issue.stub(:state).and_return(:wip)

      content = helper.issue_state(issue)
      content.should have_selector "span.tag"
      content.should have_content I18n.t("states.wip")
    end
  end

  describe :issue_reported_at do
    it "should render a tag with the date of creation" do
      date = 3.days.ago
      issue.stub(:created_at).and_return(date)

      content = helper.issue_reported_at(issue)
      content.should have_selector "span.tag"
      content.should have_content date.to_date.to_s

      issue.stub(:created_at).and_return(DateTime.now)
      content = helper.issue_reported_at(issue)
      content.should have_content "Today"
    end
  end

  describe :issue_id do
    it "should return a combined string of the project key and the issue id" do
      issue.stub_chain(:project, :key).and_return("TYNE")
      issue.stub_chain(:project, :user).and_return(user)
      issue.stub(:number).and_return(1337)

      content = helper.issue_id(issue)
      content.should have_selector "a.issue-key"
      content.should have_content "TYNE-1337"
    end
  end

  describe :issue_comments do
    it "should return a tag with the number of comments" do
      issue.stub_chain(:comments, :count).and_return(5)

      helper.issue_comments(issue).should =~ /5/
    end
  end

  describe :default_action do
    it "should return a link with the correct transition" do
      issue.stub_chain(:project, :user).and_return(user)
      issue.stub_chain(:project, :key).and_return("Foo")
      issue.stub(:number).and_return(1337)
      issue.stub(:state).and_return("open")

      helper.default_action(issue).should have_selector("a")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.start_working"))

      issue.stub(:state).and_return("reopened")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.start_working"))

      issue.stub(:state).and_return("wip")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.task_is_done"))

      issue.stub(:state).and_return("done")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.reopen"))

      issue.stub(:state).and_return("invalid")
      helper.default_action(issue).should have_content(I18n.t("states.transitions.reopen"))
    end
  end

  describe :users_to_assign do
    it "should return all workers of a project" do
      user = User.create!(:name => "Foo", :uid => "F", :token => "Foo")
      bob = User.create!(:name => "Bob", :uid => "B", :token => "Bob")
      project = user.projects.create!(:key => "FOO", :name => "Foo")
      issue = project.issues.build

      users = users_to_assign(issue)
      users.should include user
      users.should_not include bob
    end
  end
end
