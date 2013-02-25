# Represents an event that effects the sprint or its remaining
# estimates.
class SprintActivity < ActiveRecord::Base
  # Array of all valid scope changes
  VALID_ESTIMATES = Issue::VALID_ESTIMATES + Issue::VALID_ESTIMATES.map {|x| x * -1}

  attr_accessible :issue_id, :sprint_id, :type_of_change, :scope_change

  belongs_to :sprint

  validates :scope_change, :inclusion => { :in => VALID_ESTIMATES }, :allow_blank => true

  # Contains scope extensions for sprint.activitites.
  module ScopeExtensions
    # Cumulates the number of all scope changes for the given scope
    def scope_change
      sum(:scope_change)
    end
  end
end
