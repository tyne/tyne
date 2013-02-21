module TyneAuth
  # Represents an organization
  class Organization < ActiveRecord::Base
    attr_accessible :name

    has_many :organization_memberships, :class_name => 'TyneAuth::OrganizationMembership'
    has_many :users, :through => :organization_memberships, :class_name => 'TyneAuth::User'
  end
end
