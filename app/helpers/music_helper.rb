module MusicHelper
  def get_music
    params = VkRequest.form_params({
                                       :user_id => cookies[:uid],
                                       :order => 'hints',
                                       :access_token => '00aa695bb656facb72a2215604fc65a2d3dd3131491de154ca05b5d34edd98c1bd36c2dfc8e5e05f5cc69',
                                       :v => '5.37'
                                   })

    request_params = {
        :url => 'api.vk.com',
        :method => 'audio.get',
        :params => params
    }

    response = VkRequest.perform(request_params, true)

    response.map{ |key, value| value['items'].map{|v| {
        id: v['id'],
        url: v['url'],
        artist: v['artist'],
        title: v['title'],
        duration: (v['duration'].to_f/60).round(2)
    }
    }
    }.first
  end
end
