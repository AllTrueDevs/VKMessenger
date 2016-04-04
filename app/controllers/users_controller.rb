class UsersController < ApplicationController
  def index
    cookies[:access_token] = params[:access_token] unless params[:access_token].nil?
    @kek = ''
  end

  def show
  end

  def login
  end

  def authorize
    if !params[:code].empty?
      response = HTTParty.get(link(params[:code]))
      if response['error'].nil?
        cookies[:access_token] = response['access_token']
        redirect_to users_url
      else
        redirect_to login_url, notice: 'wrong code'
      end
    else
      redirect_to login_url, notice: 'enter code'
    end
  end

  def logout
    cookies[:access_token] = nil
    redirect_to login_url
  end


  private


  def link(code)
    params = VkRequest.form_params({
        :client_id => 5396125,
        :client_secret => 'jJ2aK2ct1F9PgxmOQnEQ',
        :code => code,
        :redirect_uri => 'https://oauth.vk.com/blank.html',
        :v => 5.37
    })

    request_params = {
        :url => 'oauth.vk.com/access_token',
        :params => params
    }

    VkRequest.link(request_params)
  end
end
