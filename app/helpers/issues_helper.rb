# Provides issue related helper methods
module IssuesHelper
  # Displays a label with the issue reporter
  def issue_reported_by(issue)
    issue_label(t("labels.reporter"), issue.reported_by.name)
  end

  # Displays a label with the issue type
  def issue_type(issue, short = false)
    name = if short
             issue.issue_type.name[0].upcase
           else
             issue.issue_type.name
           end
    classes = [issue.issue_type.name.underscore]
    classes << "tag-short" if short
    issue_label(t("labels.type"), name, classes) if issue.issue_type
  end

  # Displays a label with the issue priority
  def issue_priority(issue, short = false)
    return unless issue.issue_priority

    name = if short
             issue.issue_priority.name[0].upcase
           else
             issue.issue_priority.name
           end
    classes = [issue.issue_priority.name.underscore]
    classes << "tag-short" if short
    issue_label(t("labels.priority"), name, classes) if issue.issue_priority
  end

  # Displays a label with the date when the issue has been reported
  def issue_reported_at(issue)
    date = issue.created_at.to_date
    content = if date == Date.today
                t("labels.today")
              else
                date
              end
    issue_label(t("labels.opened"), content)
  end

  # Displays a label for the current state
  def issue_state(issue)
    content = I18n.t("states.#{issue.state}")
    issue_label(t("labels.state"), content, [issue.state.to_s.underscore])
  end


  # Displays a formatted string in the following format:
  # {ProjectKey}-{IssueId} e.g. TYNE-1337
  def issue_id(issue)
    klasses = ["issue-key"]
    klasses << "issue-closed" if issue.closed?
    link_to issue.key, main_app.issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.number), :class => klasses.join(" ")
  end

  # Returns the default workflow action as a link
  def default_action(issue)
    transition = case issue.state
                 when "open", "reopened"
                   :start_working
                 when "wip"
                   :task_is_done
                 when "invalid", "done"
                   :reopen
                 end
    label = I18n.t("states.transitions.#{transition}")
    url = main_app.workflow_issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.number, :transition => transition)
    link_to(label, url, :class => "btn btn-small")
  end

  # Renders a tag with the amount of comments as text.
  def issue_comments(issue)
    klasses = ["tag-short"]
    klasses << "comments-present" if issue.comments.count > 0
    issue_label(t("labels.comments"), issue.comments.count, klasses)
  end

  # Returns the list of user which can be assigned to an issue.
  # The user needs to be part of a team of the project.
  def users_to_assign(issue)
    issue.project.workers.map { |x| x.user }.uniq { |x| x.id }
  end

  # Renders an issue label with additional classes.
  def issue_label(name, value, classes=[])
    classes << "tag" unless classes.include? "tag"
    title = "#{name}: #{value}"

    content_tag :span, value, :class => classes.join(' '), :title => title
  end
end
