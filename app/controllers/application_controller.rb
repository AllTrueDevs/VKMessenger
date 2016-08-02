require 'vk_request'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
