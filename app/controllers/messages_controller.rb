class MessagesController < ApplicationController
  include Messageable
  before_action :authenticate_user!

  def change_dialog
    @messages = get_messages(params[:id])
    respond_to :js
  end

  def sending
    send_message!(params[:receiver_id].to_i, params[:body])
    respond_to :js
  end
end
