# Provides view helpers for the team area in the core engine.
module TeamsHelper
  # Returns the list of potentional team members.
  # You cannot add user which are already part of the team.
  def available_members(team)
    scope = User.scoped
    team.members.all.each do |member|
      scope = scope.where(User.arel_table[:id].not_eq(member.user.id))
    end
    scope.all
  end

  # Returns the team description depending on the access level.
  def team_description_for(team)
    i18n_scope = "descriptions.teams"
    scope = if team.admin_privileges
              "admin_html"
            else
              "default_html"
            end
    t("#{i18n_scope}.#{scope}")
  end
end
