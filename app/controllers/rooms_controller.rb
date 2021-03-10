class RoomsController < ApplicationController
  before_action :authenticate_user!
  def create
    Room.create
    Entry.create(room_id: @room.id, user_id: current_user.id)
    Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages.includes(:user)
      @message = Message.new
      @entries = @room.entries.includes(:user)
      @other_entry = @entries.where.not(user_id: current_user.id)[0]
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
