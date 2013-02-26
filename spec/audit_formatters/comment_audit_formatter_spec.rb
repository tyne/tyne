require 'spec_helper'

describe CommentAuditFormatter do
  before :each do
    Rails.application.config.stub(:assets_dir).and_return('/')
  end

  it "should format an comment audit" do
    issue = issues(:foo)
    comment = issue.comments.create(:message => "Foo") do |c|
      c.user = issue.project.user
    end
    audit = comment.audits.first
    audit.stub(:user).and_return(issue.project.user)

    audit.formatted.should_not be_empty
    audit.details.should == "Foo"
    audit.icon.should =~ /img/
  end
end
