require 'vk_request'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_access_token

  def check_access_token
    redirect_to login_url, notice: 'Log in pls' if !token_valid? && action_name != 'login'
  end


  private


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
