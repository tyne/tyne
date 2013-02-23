#Helper class for generating links to areas within the system
class LinkHelper

  #TODO: No code asserts these link contents, as discovered when extracting
  #
  attr_reader :context

  def initialize(context)
    @context = context
  end

  #Generate a link for a given issue
  def issue_link(issue)
    context.link_to "#{issue.key} - #{issue.summary}", context.issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.number)
  end

  #Generate a link for a given user§yy
  def user_link(user)
    return "Unknown" unless user
    context.link_to user.username, context.overview_path(:user => user.username)
  end

  #Generate a link for a given project
  def project_link(project)
    context.link_to project.name, context.backlog_path(:user => project.user.username, :key => project.key)
  end
end
