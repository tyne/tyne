# Represents a project.
class Project < ActiveRecord::Base
  has_associated_audits

  attr_accessible :description, :key, :name

  validates :key, :name, :user_id, :presence => true
  validates :key, :name, :uniqueness => { :scope => :user_id }
  validates :key, :format => { :with => /^[a-zA-Z\d\s]*$/ }

  belongs_to :user
  has_many :issues, :dependent => :destroy
  has_many :backlog_items, :dependent => :destroy, :order => 'position'
  has_many :sprint_items, :dependent => :destroy, :order => 'sprint_position'
  has_many :teams, :autosave => true, :dependent => :destroy
  has_many :workers, :class_name => "TeamMember", :through => :teams, :source => :members
  has_many :owners, :class_name => "TeamMember", :through => :teams, :conditions => { :teams => { :admin_privileges => true } }, :source => :members
  has_many :sprints, :dependent => :destroy

  before_create :create_teams

  def any_running?
    sprints.where(:active => true).count > 0
  end

  private
  def create_teams
    i18n_scope = "teams.names.defaults"
    owners = self.teams.build(:name => I18n.t("#{i18n_scope}.owners")) do |team|
      team.admin_privileges = true
    end
    owners.members.build(:user_id => self.user_id)
    self.teams.build(:name => I18n.t("#{i18n_scope}.contributors"))
  end
end
