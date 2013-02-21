module TyneCore
  # View helper for gravatar images
  module AvatarHelper
    # Returns the gravatar url for a particular user
    #
    # @param [TyneAuth::User] user
    # @param [Hash] options
    def avatar_url(user, options={})
      default_url = "retro"

      return default_url unless user.gravatar_id

      "http://gravatar.com/avatar/#{user.gravatar_id}.png?s=#{options[:width]}&d=#{CGI.escape(default_url)}"
    end

    # Returns a gravatar image for a particular user
    #
    # @param [TyneAuth::User] user
    # @param [Hash] options
    def avatar(user, options={})
      return unless user
      options.reverse_merge!(:url => "/", :width => 24)
      image_tag avatar_url(user, options), :class => 'avatar', :width => options[:width]
    end
  end
end
