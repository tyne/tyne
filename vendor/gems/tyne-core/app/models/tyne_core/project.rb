module TyneCore
  # Represents a project.
  class Project < ActiveRecord::Base
    has_associated_audits

    attr_accessible :description, :key, :name

    validates :key, :name, :user_id, :presence => true
    validates :key, :name, :uniqueness => { :scope => :user_id }
    validates :key, :format => { :with => /^[a-zA-Z\d\s]*$/ }

    belongs_to :user, :class_name => "TyneAuth::User"
    has_many :issues, :class_name => "TyneCore::Issue", :dependent => :destroy
    has_many :backlog_items, :class_name => "TyneCore::BacklogItem", :dependent => :destroy, :order => 'position'
    has_many :sprint_items, :class_name => "TyneCore::SprintItem", :dependent => :destroy, :order => 'sprint_position'
    has_many :teams, :class_name => "TyneCore::Team", :autosave => true, :dependent => :destroy
    has_many :workers, :class_name => "TyneCore::TeamMember", :through => :teams, :source => :members
    has_many :owners, :class_name => "TyneCore::TeamMember", :through => :teams, :conditions => { :tyne_core_teams => { :admin_privileges => true } }, :source => :members
    has_many :sprints, :class_name => "TyneCore::Sprint", :dependent => :destroy

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
end
