class Label < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :issues

  attr_accessible :name

  validates :name, :presence => true
end
