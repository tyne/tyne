# Represents an organization
class Organization < ActiveRecord::Base
  attr_accessible :name

  has_many :organization_memberships
  has_many :users, :through => :organization_memberships
end
