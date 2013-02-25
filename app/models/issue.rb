# Represents an issue that affects a particular project.
# Issues can be part of a sprint and they have an issue type.
class Issue < ActiveRecord::Base
  include Extensions::Issues::Workflow
  include Extensions::Votable

  # Array of all valid estimation options.
  VALID_ESTIMATES = [0, 0.5, 1, 2, 3, 5, 8, 13, 20, 40, 100]

  audited :associated_with => :project, :allow_mass_assignment => true

  belongs_to :reported_by, :class_name => "User"
  belongs_to :project, :touch => true
  belongs_to :issue_type
  belongs_to :issue_priority
  belongs_to :assigned_to, :class_name => "User"
  belongs_to :sprint
  has_many :comments, :dependent => :destroy

  attr_accessible :project_id, :summary, :description, :issue_type_id, :issue_priority_id, :assigned_to_id, :estimate

  validates :project_id, :summary, :issue_type_id, :number, :presence => true
  validates :number, :uniqueness => { :scope => :project_id }
  validates :estimate, :inclusion => { :in => VALID_ESTIMATES }, :allow_blank => true
  validate :security_assigned_to

  default_scope includes(:project).includes(:reported_by).includes(:issue_type).includes(:comments).includes(:issue_priority)

  after_initialize :set_defaults
  before_validation :set_number, :on => :create

  scope :sort_by_issue_type, lambda { |sord| joins(:issue_type).order("issue_types.name #{sord}") }
  scope :sort_by_issue_priority, lambda { |sord| includes(:issue_priority).order("issue_priorities.number #{sord}") }

  # Returns the issue number prefixed with the projecy key
  # to better identify issues.
  #
  # e.g. TYNE-1337
  #
  # @return [String] issue-key
  def key
    "#{project.key}-#{number}"
  end

  def closed?
    %w(done invalid).include? self.state
  end

  # Returns the description converted into markdown.
  def description_markdown
    @@markdown_renderer ||= Redcarpet::Markdown.new(MdEmoji::Render, :autolink => true, :space_after_headers => true, :no_intra_emphasis => true)
    @@markdown_renderer.render(description).html_safe
  end
  alias_method :display_as, :description_markdown

  # Removes the issue from the backlog if not part of a sprint.
  # Logs sprint activity if part of a sprint.
  def after_close
    if sprint
      change = (self.estimate || 0) * -1
      self.sprint.activities.build(:issue_id => self.id, :type_of_change => "close", :scope_change => change)
      self.sprint.save
    else
      self.becomes(BacklogItem).remove_from_list
    end
  end

  # Adds issue to the backlog if not part of a sprint.
  # Logs sprint activity if part of a sprint.
  def after_reopen
    if sprint
      self.sprint.activities.build(:issue_id => self.id, :type_of_change => "reopen", :scope_change => self.estimate || 0)
      self.sprint.save
    else
      self.becomes(BacklogItem).insert_at(1)
    end
  end

  private
  def set_defaults
    self.issue_type_id ||= IssueType.first.id if attributes.include?("issue_type_id")
    self.issue_priority_id ||= get_medium_priority if attributes.include?("issue_priority_id")
  end

  def get_medium_priority
    priority_count = IssuePriority.count
    return if priority_count == 0

    IssuePriority.all[priority_count / 2].id
  end

  def set_number
    self.number = (project.issues.maximum('number') || 0) + 1
  end

  def security_assigned_to
    return true if self.assigned_to_id.blank?

    users = project.workers.uniq { |x| x.user_id }.map { |x| x.user_id }
    errors.add(:assigned_to_id, :value_not_allowed) unless users.include?(self.assigned_to_id)
  end
end
