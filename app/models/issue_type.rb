# Represent a specific type to classify an issue.
class IssueType < ActiveRecord::Base
  attr_accessible :name

  default_scope order("name ASC")
end
