class MessagesController < ApplicationController
  before_action :authenticate_user!
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      @messages = Room.find(params[:message][:room_id]).messages.includes(:user)
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
