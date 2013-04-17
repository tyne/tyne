class IssueLabel < ActiveRecord::Base
  belongs_to :issue
  belongs_to :label

  attr_accessible :issue_id, :label_id
end
