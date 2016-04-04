class MusicController < ApplicationController
  def index
    permissions = %w(offline friends audio messages)
    params = VkRequest.form_params({
                                       :client_id => 5396125,
                                       :display => 'popup',
                                       :redirect_uri => 'https://oauth.vk.com/blank.html',
                                       :scope => VkRequest.form_permissions(permissions),
                                       :response_type => 'token',
                                       :v => 5.37
                                   })

    request_params = {
        :url => 'oauth.vk.com/authorize',
        :params => params
    }

    @link = VkRequest.link(request_params)

    params = VkRequest.form_params({
                                       :user_id => kek,
                                       :access_token => 'kek',
                                       :v => '5.37'
                                   })

    request_params = {
        :url => 'api.vk.com',
        :method => 'audio.get',
        :params => params
    }

    response = VkRequest.perform(request_params, true)

    @music = response.map{ |key, value| value['items'].map{|v| {
        id: v['id'],
        url: v['url'],
        artist: v['artist'],
        title: v['title']
    }
    }
    }.first

  end
end
