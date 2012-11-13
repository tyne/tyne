module ApplicationHelper
  def brand
    result = content_tag(:span, "Tyne", :class => "brand-name")
    result.html_safe
  end

  def project_name
    content_tag :span, "#{@project.user.username}/#{@project.key}", :class => "brand-project" if @project
  end

  def avatar_url(user, options={})
    opt = {:width => 48}.merge(options)

    default_url = "#{main_app.root_url}assets/guest.png"
    if user.gravatar_id
      "http://gravatar.com/avatar/#{user.gravatar_id}.png?s=#{opt[:width]}&d=#{CGI.escape(default_url)}"
    else
      default_url
    end
  end

  def avatar(user)
    image_tag avatar_url(user, { :width => 24 }), :class => 'avatar', :width => 24
  end
end
