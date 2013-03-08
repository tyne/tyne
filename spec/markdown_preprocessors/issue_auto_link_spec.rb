require 'spec_helper'

describe MarkdownPreprocessors::IssueAutoLink do
  it "should create project internal links" do
    project = projects(:tyne)
    issue = project.issues.first
    subject.process("##{issue.number}", project).should == "[##{issue.number}](/Tobscher/TYNE/issues/#{issue.number})"
  end

  it "should create project wide links" do
    project = projects(:tyne)
    issue = project.issues.first
    subject.process("#TYNE-#{issue.number}", project).should == "[##{issue.number}](/Tobscher/TYNE/issues/#{issue.number})"
  end

  it "should not fall over when linked to something that does not exist" do
    project = projects(:tyne)
    subject.process("#TYNE-1337", project).should == "#TYNE-1337"
    subject.process("#FOO-1337", project).should == "#FOO-1337"

    subject.process("#1337", project).should == "#1337"
  end
end
