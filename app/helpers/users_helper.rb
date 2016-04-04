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

  def get_user(id)
    params = VkRequest.form_params({
        :user_id => id,
        :fields => 'photo',
        :v => '5.37'
    })

    request_params = {
        :url => 'api.vk.com',
        :method => 'users.get',
        :params => params
    }

    VkRequest.perform(request_params, true)['response'].map{ |friend|
      {
          id: friend['id'],
          first_name: friend['first_name'],
          last_name: friend['last_name'],
          photo: friend['photo']
      }
    }.first
  end
end
