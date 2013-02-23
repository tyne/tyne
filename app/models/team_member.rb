# A team member is part of a team that belongs to a project.
class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team, :touch => true

  validates :user, :team, :presence => true
  validates :user_id, :uniqueness => { :scope => :team_id }

  attr_accessible :user_id

  default_scope includes(:user)

  def is_admin?
    team.admin_privileges if team
  end
end
