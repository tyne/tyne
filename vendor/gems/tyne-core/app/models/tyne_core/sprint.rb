module TyneCore
  # A Sprint is an iteration to deliver a subset of your product backlog
  # in a certain time frame.
  class Sprint < ActiveRecord::Base
    attr_accessible :end_date, :name, :project_id, :start_date

    belongs_to :project, :class_name => 'TyneCore::Project'
    has_many :issues, :class_name => 'TyneCore::SprintItem', :order => 'sprint_position', :dependent => :nullify

    validates :name, :start_date, :end_date, :project_id, :presence => true
    validates :active, :uniqueness => { :scope => :project_id }, :if => :active

    after_initialize :set_dates

    scope :not_running, where(:active => false, :finished => nil)

    # Starts the sprint. Only valid if there is no running sprint.
    def start(start_date, end_date)
      self.start_date = start_date
      self.end_date = end_date
      self.active = true
      save
    end

    # Finishes the sprint.
    def finish
      self.issues.not_completed.update_all(:sprint_id => nil, :sprint_position => nil)
      self.finished = DateTime.now
      self.active = false
      save
    end

    private
    def set_dates
      self.start_date = Date.today.to_date
      self.end_date = 7.days.from_now.to_date
    end
  end
end
