# Represents an user
class User < ActiveRecord::Base
  validates :name, :uid, :token, :presence => true
  attr_accessible :name, :username, :uid, :email, :token, :gravatar_id

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

  # Creates or finds a user based on the given user id.
  #
  # @param auth_hash
  # @return User
  def self.find_or_create(auth_hash)
    unless user = find_by_uid(auth_hash["uid"])
      user = create! do |user|
        user.uid = auth_hash["uid"]
        user.name = auth_hash["info"]["name"] || auth_hash["info"]["nickname"]
        user.username = auth_hash["info"]["nickname"]
        user.email = auth_hash["info"]["email"]
        user.token = auth_hash["credentials"]["token"]
        user.gravatar_id = auth_hash["extra"]["raw_info"]["gravatar_id"]
      end
    end

    user
  end

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
