# Present a membership of an organisation
class OrganizationMembership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :organization_id
end
