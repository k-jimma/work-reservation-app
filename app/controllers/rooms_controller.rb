class RoomsController < ApplicationController
  helper :application
  before_action :authenticate_user!, except: [:show]
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @rooms = current_user.rooms.order(created_at: :desc)
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: "施設を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "施設情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました。"
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def authorize_user!
    return if @room.user_id == current_user.id
    redirect_to @room, alert: "権限がありません。"
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
