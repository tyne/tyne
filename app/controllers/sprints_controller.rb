# Handles request for sprints of a project
class SprintsController < AdminController
  self.responder = ::ApplicationResponder
  respond_to :html, :json, :pjax

  before_filter :load_user
  before_filter :load_project
  before_filter :require_login, :except => [:current]
  before_filter :ensure_can_collaborate, :except => [:current]

  helper :issues

  # Displays the planning page.
  def index
    add_breadcrumb :planning

    @sprints = @project.sprints.not_running
    @issues = @project.backlog_items.not_completed.where(:sprint_id => nil)
  end

  # Creates a new sprint.
  def create
    @sprint = @project.sprints.create(:name => "Unnamed sprint")

    render @sprint
  end

  # Upates a sprint
  def update
    @sprint = @project.sprints.find(params[:id])
    @sprint.update_attributes(params[:sprint])
    respond_with(@sprint)
  end

  # Destroys a sprint
  def destroy
    @sprint = @project.sprints.find(params[:id])
    if @sprint.destroy
      render :json => :ok
    else
      render :json => { :errors => @sprint.errors }, :status => :entity_unprocessable
    end
  end

  # Changes the ranking inside a particular sprint. If the item is not already
  # in the sprint it will be added.
  # The item will get removed from the backlog if it used to be there.
  def reorder
    @issue = @project.sprint_items.find(params[:issue_id])
    @issue.becomes(BacklogItem).remove_from_list

    @issue.remove_from_list

    @issue.sprint_id = @project.sprints.find(params[:id]).id
    @issue.save

    if @issue.insert_at(params[:position].to_i)
      render :json => :ok
    else
      render :json => { :errors => @issue.errors }, :status => :entity_unprocessable
    end
  end

  # Starts a new sprint.
  def start
    @sprint = @project.sprints.find(params[:id])
    @sprint.start(params[:sprint][:start_date], params[:sprint][:end_date])

    respond_with(@sprint, :location => current_sprints_path(:user => @project.user.username, :key => @project.key))
  end

  # Finishes a sprint.
  def finish
    @sprint = @project.sprints.find(params[:id])
    @sprint.finish

    respond_with(@sprint, :location => sprints_path(:user => @project.user.username, :key => @project.key))
  end

  # Displays the agile board
  def current
    add_breadcrumb :current
    @sprint = @project.sprints.find_by_active(true)
  end
end
