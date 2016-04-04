module UsersHelper
  def form_login_link
    permissions = %w(offline friends audio messages)

    params = VkRequest.form_params({
                                       :client_id => 5396125,
                                       :display => 'page',
                                       :redirect_uri => 'https://oauth.vk.com/blank.html',
                                       :scope => VkRequest.form_permissions(permissions),
                                       :response_type => 'code',
                                       :v => 5.37
                                   })

    request_params = {
        :url => 'oauth.vk.com/authorize',
        :params => params
    }

    VkRequest.link(request_params)
  end
end
