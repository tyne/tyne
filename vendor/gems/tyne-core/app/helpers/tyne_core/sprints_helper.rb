module TyneCore
  # Provides view helpers for the sprints in the core engine.
  module SprintsHelper
    # Renders a start sprint for a particular sprint.
    # The button will be disabled if either a sprint is already running
    # or if the sprint is empty (no issues).
    def start_sprint_button(sprint)
      options = { :class => "btn btn-small start-sprint", :data => { :toggle => 'modal', :target => "#sprint_#{sprint.id}_dialog" } }

      title = ""

      if sprint.issues.empty?
        options[:disabled] = :disabled
        title = t("sprints.zero_issues")
      end

      if @project.any_running?
        options[:disabled] = :disabled
        options[:data][:running] = true
        title = t("sprints.already_running")
      end

      options[:title] = title unless title.empty?

      button_tag "Start", options
    end
  end
end
