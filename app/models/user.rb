# Represents an user
class User < ActiveRecord::Base
  validates :name, :uid, :token, :presence => true
  attr_accessible :name, :username, :uid, :email, :token, :gravatar_id, :notification_email

  has_many :organization_memberships
  has_many :organizations, :through => :organization_memberships
  has_many :projects
  has_many :team_members
  has_many :teams, :through => :team_members
  has_many :owned_projects, :through => :teams, :class_name => "Project", :source => :project, :conditions => { :teams => { :admin_privileges => true } }
  has_many :accessible_projects, :through => :teams, :class_name => "Project", :source => :project
  has_many :dashboards
  has_many :issues, :through => :projects
  has_many :reported_issues, :class_name => "Issue", :foreign_key => :reported_by_id

  after_initialize :set_defaults

  # Returns a Github API wrapper.
  #
  # @return Octokit::Client
  def github_client
    Octokit::Client.new(:login => username, :oauth_token => token)
  end

  # Returns the first dashboard in the list.
  # This method is supposed to return the dashboard that's marked as default in the nearer future.
  #
  # @return [Dashboard] default dashboard
  def default_dashboard
    dashboards.first
  end

  def set_defaults
    self.dashboards.build(:name => "Default")
  end
  private :set_defaults
end
