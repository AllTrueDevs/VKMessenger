module Messageable
  def get_messages(uid, count = 20, page = 0)
    params = VkRequest.form_params({
      :user_id => uid,
      :access_token => current_user.token,
      :v => '5.37'
    })

    request_params = {
      :url => 'api.vk.com',
      :method => 'messages.getHistory',
      :page => page,
      :count => count,
      :params => params
    }

    response = VkRequest.perform(request_params, true)
    response.map{ |key, value| value['items'].map{|v|
        {
          body: v['body'],
          from_id: v['from_id'],
          state: v['read_state'].to_i,
          date: v['date'],
        }
      }
    }.first
  end

  def send_message!(uid, body)
    params = VkRequest.form_params({
      :user_id => uid,
      :message => VkRequest.to_ahcii!(body),
      :access_token => current_user.token,
      :v => '5.37',
    })

    request_params = {
        :url => 'api.vk.com',
        :method => 'messages.send',
        :params => params
    }

    VkRequest.perform(request_params, :sent)
  end
end