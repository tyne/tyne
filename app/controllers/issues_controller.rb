# Handles requests for issue creation, updates, deletions
class IssuesController < ApplicationController
  include Extensions::ActionController::Filter
  include Extensions::ActionController::Pagination
  include Extensions::ActionController::Sorting
  include Extensions::ActionController::Query

  self.responder = ::ApplicationResponder
  respond_to :html, :json

  before_filter :load_user
  before_filter :load_project
  before_filter :require_login, :only => [:new, :create, :edit, :update, :workflow, :upvote, :downvote, :assign_to_me]
  before_filter :load_issue, :only => [:workflow, :edit, :update, :show, :upvote, :downvote, :assign_to_me]
  before_filter :ensure_can_edit, :only => [:workflow, :edit, :update, :assign_to_me]

  helper :labels

  # Displays the index view with the backlog.
  # The backlog can be sorted by passing a sorting parameter.
  def index
    reflection = @project.issues

    default_filter if default_applicable?

    reflection = apply_filter(reflection)
    reflection = apply_query(reflection)
    reflection = apply_sorting(reflection)
    reflection = apply_pagination(reflection)

    @issues = reflection
  end

  # Displays the new page for issue creation
  def new
    add_breadcrumb :new

    @issue = @project.issues.build
    @label = @project.labels.build

    @template = params[:template]
    @issue.apply_template(@template) if @template
  end

  # Creates a new issue
  def create
    add_breadcrumb :new

    create_another = !!params[:issue].delete(:create_another)

    @issue = @project.backlog_items.build(params[:issue])
    @issue.reported_by = current_user

    if @issue.save
      IssueMailer.send_issue_raised(@issue.id)

      redirect_to_path = new_issue_path(:user => @project.user.username, :key => @project.key, :template => @issue.number) if create_another
    end

    respond_with(@issue, :location => redirect_to_path || show_path)
  end

  # Performs a workflow transition
  def workflow
    @issue.send(params[:transition]) if @issue.state_transitions.any? { |x| x.event == params[:transition].to_sym }

    respond_with @issue do |format|
      format.html { redirect_to show_path }
    end
  end

  # Displays the edit page for an issue.
  def edit
    @label = @project.labels.build
    respond_with(@issue)
  end

  # Updates a given issue
  def update
    @issue.update_attributes(params[:issue])
    respond_with(@issue, :location => show_path) do |format|
      format.json { render :json => @issue.to_json(:methods => [:display_as]) }
    end
  end

  # Displays an existing Issue
  def show
    respond_with(@issue)
  end

  # Votes the issue up
  def upvote
    @issue.upvote_for(current_user)
    render :json => @issue.total_votes.to_json
  end

  # Votes the issue down
  def downvote
    @issue.downvote_for(current_user)
    render :json => @issue.total_votes.to_json
  end

  # Assign issue to me
  def assign_to_me
    @issue.assigned_to = current_user
    @issue.save
    respond_with(@issue, :location => show_path)
  end

  # Changes the ranking of an issue inside the backlog.
  # If the item is not already in the backlog it will be added.
  # It will also get removed from any sprint.
  def reorder
    @issue = @project.backlog_items.find(params[:issue_id])
    @issue.becomes(SprintItem).remove_from_list if @issue.sprint

    @issue.remove_from_list

    @issue.sprint_id = nil
    @issue.save

    if @issue.insert_at(params[:position].to_i)
      render :json => @issue
    else
      render :json => { :errors => @issue.errors }, :status => :entity_unprocessable
    end
  end

  private

  def show_path
    issue_path(:user => @project.user.username, :key => @project.key, :id => @issue.number)
  end

  def can_edit?
    users = @issue.project.workers.uniq { |x| x.user_id }.map { |x| x.user }
    users.include?(current_user)
  end
  helper_method :can_edit?

  def ensure_can_edit
    redirect_to root_path unless can_edit?
  end

  def default_filter
    @default_filter = true
    params[:filter] ||= {}
    params[:filter][:state] = ["open", "reopened"]
  end

  def default_applicable?
    return false unless formats.include?(:html)

    [:filter, :sorting, :paginationi, :query].each do |option|
      return false if params[option].present?
    end
  end
end
