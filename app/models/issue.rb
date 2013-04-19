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
  has_many :issue_labels
  has_many :labels, :through => :issue_labels

  accepts_nested_attributes_for :issue_labels, :allow_destroy => true

  attr_accessible :project_id, :summary, :description, :issue_type_id, :issue_priority_id, :assigned_to_id, :estimate, :issue_labels_attributes

  validates :project_id, :summary, :issue_type_id, :number, :presence => true
  validates :number, :uniqueness => { :scope => :project_id }
  validates :estimate, :inclusion => { :in => VALID_ESTIMATES }, :allow_blank => true
  validate :security_assigned_to

  default_scope includes(:project).includes(:reported_by).includes(:issue_type).includes(:comments).includes(:issue_priority)

  after_initialize :set_defaults
  before_validation :set_number, :on => :create

  scope :sort_by_issue_type, lambda { |sord| joins(:issue_type).order("issue_types.name #{sord}") }
  scope :sort_by_issue_priority, lambda { |sord| includes(:issue_priority).order("issue_priorities.number #{sord}") }
  scope :filter_by_label, lambda { |labels|
    includes(:issue_labels).where(:issue_labels => { :label_id => labels })
  }

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
    preprocessed = MarkdownPreprocessors::IssueAutoLink.new.process(description, project)
    @@markdown_renderer.render(preprocessed).html_safe
  end
  alias_method :display_as, :description_markdown

  # Callback fired after ticked closed
  def after_close
    if sprint
      log_sprint_activity('close', 0 - estimated_remaining)
    else
      remove_from_backlog
    end
    IssueMailer.delay.issue_closed(self.id)
  end

  # Callback fired afer ticket reopened
  def after_reopen
    if sprint
      log_sprint_activity('reopen', estimated_remaining)
    else
      add_to_backlog
    end
    IssueMailer.delay.issue_reopened(self.id)
  end

  # Applies issue details from an existing issue
  # @param [Integer] issue number
  def apply_template(template)
    return unless self.project
    return unless (issue_template = self.project.issues.find_by_number(template))

    self.issue_type = issue_template.issue_type
    self.issue_priority = issue_template.issue_priority
    self.assigned_to = issue_template.assigned_to
  end

  private

  def remove_from_backlog
    becomes(BacklogItem).remove_from_list
  end

  def add_to_backlog
    becomes(BacklogItem).insert_at(1)
  end

  def estimated_remaining
    estimate || 0
  end

  def log_sprint_activity(type, change)
    sprint.log_activity(self, type, change)
    sprint.save
  end

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
