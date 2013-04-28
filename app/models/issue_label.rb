# Assigned Label to an issue
class IssueLabel < ActiveRecord::Base
  belongs_to :issue, :touch => true
  belongs_to :label

  attr_accessible :issue_id, :label_id
  before_save :secure_labels

  private
  def secure_labels
    if (self.issue.project != self.label.project)
      errors.add(:base, :unknown_label)
    end

    return errors.empty?
  end
end
