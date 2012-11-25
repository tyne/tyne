module AvatarHelper
  def avatar_url(user, options={})
    default_url = "#{main_app.root_url}assets/guest.png"

    return default_url unless user.gravatar_id

    opt = {:width => 48}.merge(options)
    "http://gravatar.com/avatar/#{user.gravatar_id}.png?s=#{opt[:width]}&d=#{CGI.escape(default_url)}"
  end

  def avatar(user)
    image_tag avatar_url(user, { :width => 24 }), :class => 'avatar', :width => 24
  end
end
