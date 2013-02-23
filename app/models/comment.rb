# A comment is a message on a issue
class Comment < ActiveRecord::Base
  audited :associated_with => :project, :allow_mass_assignment => true

  belongs_to :user
  belongs_to :issue, :touch => true

  validates :message, :issue_id, :user_id, :presence => true

  attr_accessible :message

  delegate :project, :to => :issue
end
