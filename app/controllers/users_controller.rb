class UsersController < ApplicationController
  def index
    @friends = get_friends
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
        cookies[:uid] = response['user_id']
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

  def get_friends
    params = VkRequest.form_params({
                                       :user_id => cookies[:uid],
                                       :order => 'hints',
                                       :access_token => '00aa695bb656facb72a2215604fc65a2d3dd3131491de154ca05b5d34edd98c1bd36c2dfc8e5e05f5cc69',
                                       :v => '5.37'
                                   })

    request_params = {
        :url => 'api.vk.com',
        :method => 'friends.get',
        :params => params
    }

    response = VkRequest.perform(request_params, true)
    friends = response.map{|key, value| value['items'] }.first
    params = VkRequest.form_params(
        {
            :user_ids => friends.map(&:to_s).join('%2C%20'),
            :fields => 'photo'
        }
    )

    request_params = {
        :url => 'api.vk.com',
        :method => 'users.get',
        :params => params
    }

    response = VkRequest.perform(request_params, true)
    response['response'].map{ |friend|
      {
        first_name: friend['first_name'],
        last_name: friend['last_name'],
        photo: friend['photo']
      }
    }
  end
end
