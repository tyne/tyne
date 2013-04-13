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
  has_many :labels

  before_create :create_teams

  scope :most_active, ->(limit) { privacy_public.order("updated_at DESC").limit(limit) }
  scope :privacy_public, -> { where(:privacy => false) }
  scope :privacy_private, -> { where(:privacy => true) }

  def any_running?
    sprints.where(:active => true).count > 0
  end

  # Returns the current sprint if there is any running.
  #
  # @return [Sprint] current sprint
  def current_sprint
    sprints.find_by_active(true)
  end

  # Returns the full name of the project including the username (e.g. Foo/Bar)
  def full_name
    "#{self.user.username}/#{self.key}"
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
