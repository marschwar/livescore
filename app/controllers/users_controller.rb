class UsersController < ApplicationController
  def index
    query = params[:q]
    raise unless query.present? && query.length > 2
    @user_names = User.is_like(query).map &:common_name
    respond_to do |format|
      format.json { render json: @user_names }
    end
  end
end
