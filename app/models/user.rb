# Represents an user
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable,
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :username, :gravatar_id, :notification_email, :login

  validates :username, :presence => true, :uniqueness => true

  attr_accessor :login

  before_save :set_gravatar_id

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

  # Overrides authentication method to enabled login via Username or E-Mail.
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # Returns the first dashboard in the list.
  # This method is supposed to return the dashboard that's marked as default in the nearer future.
  #
  # @return [Dashboard] default dashboard
  def default_dashboard
    dashboards.first
  end

  private
  def set_defaults
    self.dashboards.build(:name => "Default")
  end

  def set_gravatar_id
    self.gravatar_id = Digest::MD5.hexdigest(self.email).to_s
  end
end
