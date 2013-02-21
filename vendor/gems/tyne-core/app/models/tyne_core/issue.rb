require "tyne_core/extensions/issues/workflow"

module TyneCore
  # Represents an issue that affects a particular project.
  # Issues can be part of a sprint and they have an issue type.
  class Issue < ActiveRecord::Base
    include TyneCore::Extensions::Issues::Workflow
    include TyneCore::Extensions::Votable

    audited :associated_with => :project, :allow_mass_assignment => true

    belongs_to :reported_by, :class_name => "TyneAuth::User"
    belongs_to :project, :class_name => "TyneCore::Project", :touch => true
    belongs_to :issue_type, :class_name => "TyneCore::IssueType"
    belongs_to :issue_priority, :class_name => "TyneCore::IssuePriority"
    belongs_to :assigned_to, :class_name => "TyneAuth::User"
    belongs_to :sprint, :class_name => "TyneCore::Sprint"
    has_many :comments, :class_name => "TyneCore::Comment", :dependent => :destroy

    attr_accessible :project_id, :summary, :description, :issue_type_id, :issue_priority_id, :assigned_to_id, :estimate

    validates :project_id, :summary, :issue_type_id, :number, :presence => true
    validates :number, :uniqueness => { :scope => :project_id }
    validates :estimate, :inclusion => { :in => [0, 0.5, 1, 2, 3, 5, 8, 13, 20, 40, 100] }, :allow_blank => true
    validate :security_assigned_to

    default_scope includes(:project).includes(:reported_by).includes(:issue_type).includes(:comments).includes(:issue_priority)

    after_initialize :set_defaults
    before_validation :set_number, :on => :create

    scope :sort_by_issue_type, lambda { |sord| joins(:issue_type).order("tyne_core_issue_types.name #{sord}") }
    scope :sort_by_issue_priority, lambda { |sord| includes(:issue_priority).order("tyne_core_issue_priorities.number #{sord}") }

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

    private
    def set_defaults
      self.issue_type_id ||= TyneCore::IssueType.first.id if attributes.include?("issue_type_id")
      self.issue_priority_id ||= get_medium_priority if attributes.include?("issue_priority_id")
    end

    def get_medium_priority
      priority_count = TyneCore::IssuePriority.count
      return if priority_count == 0

      TyneCore::IssuePriority.all[priority_count / 2].id
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
end
