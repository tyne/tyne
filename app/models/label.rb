class Label < ActiveRecord::Base
  belongs_to :project
  has_many :issue_labels
  has_many :issues, :through => :issue_labels

  attr_accessible :name

  validates :name, :presence => true
end
