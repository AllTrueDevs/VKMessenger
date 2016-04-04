require 'vk_request'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_access_token

  def check_access_token
    # redirect_to login_users_url if cookies[:access_token].blank?
  end


  private


  def token_valid?
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

    puts VkRequest.perform(request_params)
  end
end
