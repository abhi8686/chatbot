module ApplicationHelper

def avatar_profile_link(user, style="", image_options={}, html_options={})
    if style.empty?
      avatar_url = user.avatar? ? user.avatar.url : user.gravatar_url
    else
      avatar_url = user.avatar? ? user.avatar.url(style.to_sym) : user.gravatar_url(style)
    end
    link_to(image_tag(avatar_url, image_options), profile_path(user.profile_name), html_options)
end

def flash_class (type)
    case type
    when 'alert'
        "alert-danger"
    when 'notice'
        "alert-success"
    else
        "alert-warning"
    end
end

 def resource_name
    :user
  end

  def resource_class 
     User 
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


end
