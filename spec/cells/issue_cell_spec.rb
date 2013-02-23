require 'spec_helper'

describe IssueCell do
  subject { cell(:issue) }

  describe :create do
    it "should render the view" do
      expected = "path_to_dialog"

      subject.should_receive(:render)

      subject.create(expected)
      subject.instance_variable_get(:@dialog_path).should == expected
    end
  end
end
