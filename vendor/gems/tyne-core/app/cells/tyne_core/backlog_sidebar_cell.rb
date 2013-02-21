module TyneCore
  # Cell for backlog sidebar
  class BacklogSidebarCell < Cell::Rails
    # Displays a pod with predefined search options
    def search
      render
    end

    # Displays a filter pod
    def filter(project)
      workers = project.workers.map { |x| [x.user.username, x.user.id] }
      assignees = workers.dup.unshift ["Unassigned", "-1"]

      @fields = [
        [:issue_type_id, TyneCore::IssueType.all.map { |x| [x.name, x.id] } ],
        [:issue_priority_id, TyneCore::IssuePriority.all.map { |x| [x.name, x.id] }],
        [:state, TyneCore::Issue.state_machine.states.map { |x| [I18n.t("states.#{x.name}"),  x.name] } ],
        [:assigned_to_id, assignees],
        [:reported_by_id, workers]
      ]
      render
    end

    # Displays a sorting pod
    def sorting
      fields = [:created_at, :updated_at, :issue_type, :state, :issue_priority]
      order = [:asc, :desc]

      @fields = fields.map { |x| [TyneCore::Issue.human_attribute_name(x), x] }
      @orders = order.map { |x| [I18n.t("order.#{x}"), x] }
      @field = session[:sorting] ? session[:sorting][:field] : :created_at
      @order = session[:sorting] ? session[:sorting][:order] : :asc

      render
    end

    # Displays a grouping pod
    def grouping
      render
    end
  end
end
