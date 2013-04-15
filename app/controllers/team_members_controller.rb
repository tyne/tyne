# Handle request to add and remove team members from a team
class TeamMembersController < AdminController
  self.responder = ::ApplicationResponder
  respond_to :html, :json

  before_filter :load_user
  before_filter :load_project
  before_filter :require_login
  before_filter :require_owner

  # Adds a team member to a team.
  def create
    @team = @project.teams.find_by_id(params[:team_id])
    @team_member = @team.members.build(params[:team_member])
    @team_member.save

    respond_with(@team_member, :location => team_path(:user => current_user.username, :key => @project.key, :id => @team.id))
  end

  # Removes a team member from a team. The current user cannot remove itself
  # from the owner team to not lose admin privileges.
  def destroy
    @team = @project.teams.find_by_id(params[:team_id])
    @team_member = @team.members.find_by_id(params[:id])

    if is_losing_admin_rights?(@team_member)
      @team_member.errors.add(:base, :losing_admin_rights)
    else
      @team_member.destroy
    end

    respond_with(@team_member, :location => team_path(:user => current_user.username, :key => @project.key, :id => @team.id), :flash_now => false)
  end

  private
  def is_losing_admin_rights?(team_member)
    team_member.user == current_user && team_member.is_admin?
  end
end
