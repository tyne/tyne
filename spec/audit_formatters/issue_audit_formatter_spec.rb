require 'spec_helper'

describe IssueAuditFormatter do
  before :each do
    Rails.application.config.stub(:assets_dir).and_return('/')
  end

  it "should format an issue audit" do
    issue = create(:issue, :description => "baz")
    audit = issue.audits.first
    audit.stub(:user).and_return(issue.project.user)

    audit.formatted.should_not be_empty
    audit.details.should == "baz"
    audit.icon.should =~ /img/
  end

  describe :update do
    let(:issue) { create(:issue) }
    let(:bob) { create(:bob) }

    it "should format an issue audit for update" do
      issue.description = "Foo"
      issue.save!

      audit = issue.audits.last
      audit.stub(:user).and_return(issue.project.user)

      audit.formatted.should_not be_empty
      audit.icon.should =~ /img/
    end

    it "should format changes to the workflow" do
      issue.start_working

      audit = issue.audits.last
      audit.stub(:user).and_return(issue.project.user)

      audit.formatted.should_not be_empty
    end

    it "should format changes to the assignee" do
      member = issue.project.teams.first.members.build(:user_id => bob.id)
      member.save!

      issue.assigned_to_id = bob.id
      issue.save!

      audit = issue.audits.last
      audit.stub(:user).and_return(issue.project.user)

      audit.formatted.should_not be_empty
    end
  end
end
