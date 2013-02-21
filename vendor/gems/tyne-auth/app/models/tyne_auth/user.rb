module TyneAuth
  # Represents an user
  class User < ActiveRecord::Base
    validates :name, :uid, :token, :presence => true
    attr_accessible :name, :username, :uid, :email, :token, :gravatar_id

    has_many :organization_memberships, :class_name => 'TyneAuth::OrganizationMembership'
    has_many :organizations, :through => :organization_memberships, :class_name => 'TyneAuth::Organization'

    # Creates or finds a user based on the given user id.
    #
    # @param auth_hash
    # @return TyneAuth::User
    def self.find_or_create(auth_hash)
      unless user = find_by_uid(auth_hash["uid"])
        user = create! do |user|
          user.uid = auth_hash["uid"]
          user.name = auth_hash["info"]["name"] || auth_hash["info"]["nickname"]
          user.username = auth_hash["info"]["nickname"]
          user.email = auth_hash["info"]["email"]
          user.token = auth_hash["credentials"]["token"]
          user.gravatar_id = auth_hash["extra"]["raw_info"]["gravatar_id"]
        end
      end

      user
    end

    # Returns a Github API wrapper.
    #
    # @return Octokit::Client
    def github_client
      Octokit::Client.new(:login => username, :oauth_token => token)
    end
  end
end
