# Assigned Label to an issue
class IssueLabel < ActiveRecord::Base
  belongs_to :issue, :touch => true
  belongs_to :label

  attr_accessible :issue_id, :label_id
  validate :secure_labels

  private
  def secure_labels
    issue = Issue.find(self.issue_id)
    label = Label.find(self.label_id)

    if (issue.project != label.project)
      errors.add(:base, :unknown_label)
    end

    return errors.empty?
  end
end
