# A SprintItem is an Issue that is part of a particular sprint.
class SprintItem < Issue
  acts_as_list :scope => :sprint, :column => "sprint_position"
end
