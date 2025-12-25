class HomeController < ApplicationController
  def index
    @rooms = Room.order(created_at: :desc).limit(12)
  end
end
