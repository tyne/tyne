require 'spec_helper'

describe ApplicationHelper do
  describe :markup_to_html do
    it "should convert markdown into html" do
      markdown = <<EOS
* Foo
* Bar
* Baz
EOS
      content = helper.markup_to_html(markdown)
      content.should have_selector("li", :count => 3)
    end
  end

  describe :path_to_issue do
    it "should delegate to main_app.issue_path" do
      issue = FactoryGirl.build_stubbed(:issue)
      issue.stub(:number).and_return(1)
      helper.path_to_issue(issue).should == issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => 1)
    end
  end
end
