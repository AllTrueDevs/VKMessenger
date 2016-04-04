class UsersController < ApplicationController
  def index
    params = VkRequest.form_params({
                                       :token => cookies[:access_token],
                                       :ip => request.remote_ip,
                                       :version => '5.50'
                                   })

    request_params = {
        :url => 'api.vk.com',
        :method => 'secure.checkToken',
        :params => params
    }

    @kek = VkRequest.perform(request_params)
  end

  def show
  end

  def login
  end
end
