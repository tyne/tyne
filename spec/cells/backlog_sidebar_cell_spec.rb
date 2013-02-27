require 'spec_helper'

describe BacklogSidebarCell do
  subject { cell(:backlog_sidebar) }

  describe :search do
    it "should render the view" do
      subject.stub_chain(:controller, :current_user, :id)
      subject.should_receive(:render)
      subject.search
    end
  end

  describe :filter do
    it "should render the view" do
      subject.should_receive(:render)
      subject.filter(Project.new)
    end
  end

  describe :sorting do
    it "should render the view" do
      subject.should_receive(:render)
      subject.sorting
    end
  end

  describe :grouping do
    it "should render the view" do
      subject.should_receive(:render)
      subject.grouping
    end
  end
end
