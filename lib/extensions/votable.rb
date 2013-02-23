module Extensions
  # The Votable extensions allows arbitrary resources to be votable by users
  module Votable
    extend ActiveSupport::Concern

    included do
      has_many :votes, :as => :votable
    end

    # Returns the total weight of upvotes
    #
    # @return [Integer]
    def upvotes
      votes.where(Vote.arel_table[:weight].gt(0)).sum(:weight)
    end

    # Returns the total weight of downvotes (as a positive number)
    #
    # @return [Integer]
    def downvotes
      votes.where(Vote.arel_table[:weight].lt(0)).sum(:weight).abs
    end

    # Returns the total weight of votes (math.: upvotes - downvotes)
    #
    # @return [Integer]
    def total_votes
      votes.sum(:weight)
    end

    # Checks if the given user already voted for the votable object
    #
    # @param [User] user
    # @return [Boolean]
    def voted?(user)
      votes.where(:user_id => user.id).exists?
    end

    # Votes for the given user using the specified weight
    #
    # @param [User] user
    # @param [Integer] weight
    # @return [Boolean]
    def vote_for(user, weight)
      votes.create(:user => user, :weight => weight)
    end

    # Upvotes for the given user
    #
    # @param [User] user
    # @return [Boolean]
    def upvote_for(user)
      return unless vote_weight_for_user(user) < 1
      vote_for(user, 1)
    end

    # Downvotes for the given user
    #
    # @param [User] user
    # @return [Boolean]
    def downvote_for(user)
      return unless vote_weight_for_user(user) > -1
      vote_for(user, -1)
    end

    private

    def vote_weight_for_user(user)
      votes.where(:user_id => user.id).sum(:weight)
    end

  end
end
