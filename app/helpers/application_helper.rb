module ApplicationHelper
  def token_valid?
    params = VkRequest.form_params({
                                       :filter => 0,
                                       :count => 1,
                                       :access_token => cookies[:access_token],
                                       :v => '5.37'
                                   })

    request_params = {
        :url => 'api.vk.com',
        :method => 'messages.get',
        :params => params
    }

    VkRequest.perform(request_params, true)['error'].nil?
  end
end
