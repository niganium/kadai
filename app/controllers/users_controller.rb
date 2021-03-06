class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    room_match_confirmation(@user)
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def room_match_confirmation(user)
    @current_user_entry = Entry.where(user_id: current_user.id)
    @other_user_entry = Entry.where(user_id: user.id)
    my_room_number = @current_user_entry.pluck(:room_id)
    room_number = @other_user_entry.pluck(:room_id)
    room_intersection = room_number & my_room_number
    if @user.id != current_user.id
      if !room_intersection.empty?
        @isRoom = true
        @room_id = room_intersection[0]
      else
        @isRoom = false
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
end
