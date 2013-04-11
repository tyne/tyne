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

  # Renders a button to finish the sprint. The action requires a confirmation.
  def finish_button
    finish_url = finish_sprint_path(:user => @sprint.project.user.username, :key => @sprint.project.key, :id => @sprint.id)
    data = {
      :"confirm-title" => "Finish sprint #{@sprint.name}",
      :"confirm-proceed" => "Finish",
      :"confirm-proceed-class" => "btn-success"
    }
    options = {
      :class => "btn btn-small",
      :confirm => "Are you sure you wish to finish your sprint?",
      :method => :put,
      :data => data
    }
    link_to("Finish", finish_url, options)
  end

  # Renders a link to the burn down chart
  def burn_down_link
    link_to("View Burn Down", burn_down_reports_path(:user => @sprint.project.user.username, :key => @sprint.project.key))
  end
end
