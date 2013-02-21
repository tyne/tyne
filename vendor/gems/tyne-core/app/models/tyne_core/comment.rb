module TyneCore
  # A comment is a message on a issue
  class Comment < ActiveRecord::Base
    audited :associated_with => :project, :allow_mass_assignment => true

    belongs_to :user, :class_name => "TyneAuth::User"
    belongs_to :issue, :class_name => "TyneCore::Issue", :touch => true

    validates :message, :issue_id, :user_id, :presence => true

    attr_accessible :message

    delegate :project, :to => :issue
  end
end
