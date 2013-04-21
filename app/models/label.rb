# A label for an issue
class Label < ActiveRecord::Base
  belongs_to :project
  has_many :issue_labels, :dependent => :destroy
  has_many :issues, :through => :issue_labels

  attr_accessible :name, :colour

  validates :name, :presence => true
  validates :name, :uniqueness => { :scope => :project_id }
end
