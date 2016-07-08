class UsersController < ApplicationController
  include EntityImage

  before_action :set_user, only: [:show]

  def index
    query = params[:q]
    raise unless query.present? && query.length > 2
    @user_names = User.active.is_like(query).map &:common_name
    respond_to do |format|
      format.json { render json: @user_names }
    end
  end

  # GET /users/1
  # GET /users/1.jpeg
  def show
    respond_to do |format|
      format.png { send_image @user.raw_image_data, :png }
      format.jpg { send_image @user.raw_image_data, :jpeg }
      format.html { }
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
