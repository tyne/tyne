# Represents the priority of an issue.
class IssuePriority < ActiveRecord::Base
  attr_accessible :name, :number

  default_scope order("number ASC")
end
