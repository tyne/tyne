class SprintActivity < ActiveRecord::Base
  VALID_ESTIMATES = Issue::VALID_ESTIMATES + Issue::VALID_ESTIMATES.map {|x| x * -1}

  attr_accessible :issue_id, :sprint_id, :type_of_change, :scope_change

  belongs_to :sprint

  validates :scope_change, :inclusion => { :in => VALID_ESTIMATES }, :allow_blank => true

  module ScopeExtensions
    def scope_change
      sum(:scope_change)
    end
  end
end
