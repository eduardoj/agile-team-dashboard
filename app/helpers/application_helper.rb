module ApplicationHelper
  def new_link_to(resource, text = 'new')
    url = url_for(action: :new, controller: resource)
    link_to text, url, class: 'ui right floated inverted green button'
  end

  def gravatar(url, alt = 'gravatar')
    image_tag url, class: 'ui avatar image mini', alt: alt
  end

  def github_link_to(login)
    url = "https://github.com/#{login}"
    link_to url, target: :_blank do
      safe_join([content_tag(:i, '', class: 'github icon'), login])
    end
  end

  def avatar(user, size: 200, gravatar: false)
    if gravatar
      klass = 'ui avatar image mini'
    else
      klass = 'ui fluid circular image'
    end
    if user.github_login
      url = "https://github.com/#{user.github_login}.png?size=#{size}"
      image_tag url, class: klass
    else
      image_tag Identicon.data_url_for(user.email), class: klass
    end
  end
end
