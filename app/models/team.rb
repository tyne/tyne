# Represents a team for a project.
# A team can allow a member to have admin privileges.
class Team < ActiveRecord::Base
  belongs_to :project, :touch => true
  has_many :members, :class_name => "TeamMember", :autosave => true, :dependent => :destroy

  validates :project, :presence => true
  attr_accessible :name
end
