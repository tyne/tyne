# Cell for backlog sidebar
class BacklogSidebarCell < Cell::Rails
  helper FilterHelper

  # Displays a pod with predefined search options
  def search(default_filter = false)
    @klass = default_filter ? "selected" : ""
    @predefined = {}
    @predefined[:open] = { :state => [:open, :reopened] }
    @predefined[:my_open] = { :state => [:open, :reopened], :assigned_to_id => [controller.current_user.id] } if controller.current_user

    render
  end

  # Displays a filter pod
  def filter(project)
    workers = project.workers.map { |x| [x.user.username, x.user.id] }
    assignees = workers.dup.unshift ["Unassigned", "-1"]
    labels = project.labels.map { |x| [x.name, x.id] }

    @fields = [
      [:issue_type_id, IssueType.all.map { |x| [x.name, x.id] } ],
      [:issue_priority_id, IssuePriority.all.map { |x| [x.name, x.id] }],
      [:state, Issue.state_machine.states.map { |x| [I18n.t("states.#{x.name}"),  x.name] } ],
      [:assigned_to_id, assignees],
      [:reported_by_id, workers],
      [:label, labels]
    ]
    render
  end

  # Displays a sorting pod
  def sorting
    fields = [:created_at, :updated_at, :issue_type, :state, :issue_priority]
    order = [:asc, :desc]

    @fields = fields.map { |x| [Issue.human_attribute_name(x), x] }
    @orders = order.map { |x| [I18n.t("order.#{x}"), x] }
    @field = session[:sorting] ? session[:sorting][:field] : :created_at
    @order = session[:sorting] ? session[:sorting][:order] : :asc

    render
  end

  # Displays a grouping pod
  def grouping
    render
  end

  # Displays a search field
  def query
    @term = params[:query]

    render
  end
end
