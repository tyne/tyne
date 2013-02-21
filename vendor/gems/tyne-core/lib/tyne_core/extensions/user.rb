module TyneCore
  module Extensions
    # Extends the user object from TyneAuth
    module User
      extend ActiveSupport::Concern

      included do
        has_many :projects, :class_name => "TyneCore::Project"
        has_many :team_members, :class_name => "TyneCore::TeamMember"
        has_many :teams, :class_name => "TyneCore::Team", :through => :team_members
        has_many :owned_projects, :through => :teams, :class_name => "TyneCore::Project", :source => :project, :conditions => { :tyne_core_teams => { :admin_privileges => true } }
        has_many :accessible_projects, :through => :teams, :class_name => "TyneCore::Project", :source => :project
        has_many :dashboards, :class_name => "TyneCore::Dashboard"
        has_many :issues, :through => :projects, :class_name => "TyneCore::Issue"
        has_many :reported_issues, :class_name => "TyneCore::Issue", :foreign_key => :reported_by_id

        after_initialize :set_defaults
      end

      # Returns the first dashboard in the list.
      # This method is supposed to return the dashboard that's marked as default in the nearer future.
      #
      # @return [TyneCore::Dashboard] default dashboard
      def default_dashboard
        dashboards.first
      end

      def set_defaults
        self.dashboards.build(:name => "Default")
      end
      private :set_defaults
    end
  end
end
