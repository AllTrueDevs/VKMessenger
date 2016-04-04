class MusicController < ApplicationController
  def index
    @music = get_music
  end


  private


  def get_music
    params = VkRequest.form_params({
        :user_id => cookies[:uid],
        :order => 'hints',
        :access_token => cookies[:access_token],
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
          duration: form_duration(v['duration'].to_i)
        }
      }
    }.first
  end

  def form_duration(duration)
    result = (duration >= 3600)? "#{prepend(duration.to_i / 3600)}:" : ''
    result += "#{!(duration.to_i / 60).zero? ? prepend(duration.to_i / 60 - (duration.to_i / 3600) * 60) : '00'}:"
    result.concat "#{!duration.to_i.zero? ? prepend(duration.to_i % 60) : '00'}"
  end

  def prepend(result)
    (result < 10)? "0#{result}" : result.to_s
  end
end
