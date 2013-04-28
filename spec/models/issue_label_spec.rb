require 'spec_helper'

describe IssueLabel do
  describe :validations do
    let(:project) { projects(:tyne) }
    let(:other_project) { projects(:bluffr) }
    let(:issue) { project.issues.first }

    it "does not allow you to add labels from other projects" do
      bar = other_project.labels.create!(:name => "Bar")

      issue_label = IssueLabel.new(:issue_id => issue.id, :label_id => bar.id)
      issue_label.save.should be_false
    end
  end
end
