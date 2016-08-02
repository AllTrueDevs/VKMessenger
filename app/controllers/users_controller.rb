class UsersController < ApplicationController
  include Messageable
  before_action :authenticate_user!, except: :authorize

  def index
    @friends = get_friends
    @messages = get_messages(@friends[0][:id])
  end

  def show
  end

  def authorize
    if !params[:code].empty?
      response = HTTParty.get(link(params[:code]))
      if response['error'].nil?
        user = User.find_by_uid(response['user_id'].to_i)
        if token_valid?(response['access_token'])
          if user.present?
            user.update(token: response['access_token'])
          else
            user.create(uid: response['user_id'].to_i, token: response['access_token'])
          end
          sign_in user
          redirect_to root_url
        else
          redirect_to new_user_session_url, notice: 'Недійсний код доступу'
        end
      else
        redirect_to new_user_session_url, notice: 'Некоректний код'
      end
    else
      redirect_to new_user_session_url, notice: 'Введіть код'
    end
  end


  private


  def token_valid?(token)
    params = VkRequest.form_params({
       :filter => 0,
       :count => 1,
       :access_token => token,
       :v => '5.37'
    })

    request_params = {
        :url => 'api.vk.com',
        :method => 'messages.get',
        :params => params
    }

    VkRequest.perform(request_params, true)['error'].nil?
  end


  def link(code)
    params = VkRequest.form_params({
        :client_id => ENV['VK_APP'],
        :client_secret => ENV['VK_SECRET'],
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

  def get_friends
    params = VkRequest.form_params({
        :user_id => current_user.uid,
        :order => 'hints',
        :fields => 'photo',
        :access_token => current_user.token,
        :v => '5.37'
    })

    request_params = {
        :url => 'api.vk.com',
        :method => 'friends.get',
        :params => params
    }

    response = VkRequest.perform(request_params, true)
    response.map{|key, value| value['items'] }.first[0..-2].map{ |friend|
      {
          id: friend['id'],
          first_name: friend['first_name'],
          last_name: friend['last_name'],
          photo: friend['photo'],
          online: friend['online']
      }
    }
  end
end
