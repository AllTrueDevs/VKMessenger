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

  def get_friends
    params = VkRequest.form_params({
                                       :user_id => cookies[:uid],
                                       :order => 'hints',
                                       :access_token => '00aa695bb656facb72a2215604fc65a2d3dd3131491de154ca05b5d34edd98c1bd36c2dfc8e5e05f5cc69',
                                       :v => '5.37'
                                   })

    request_params = {
        :url => 'api.vk.com',
        :method => 'friends.get',
        :params => params
    }

    response = VkRequest.perform(request_params, true)
    count, friends = response['count'], response.map{|key, value| value['items'] }.first
    params = VkRequest.form_params({ :user_ids => friends.map(&:to_s).join('%2C%20') })

    request_params = {
        :url => 'api.vk.com',
        :method => 'users.get',
        :params => params
    }

    response = VkRequest.perform(request_params, true)
    response['response'].map{ |friend| { first_name: friend['first_name'], last_name: friend['last_name'] } }
    end
end
