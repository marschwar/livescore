class SupportersController < ApplicationController
  before_action :set_and_authorize_game, only: [:create, :destroy]

  # POST /games/:game_id/notes
  # POST /games/:game_id/notes.json
  def create
    user = User.where(common_name: supporter_params[:user] ).first
    if user
      @supporter = Supporter.new.tap do |s|
        s.user = user
        s.game = @game
      end
      @supporter.save
    end
    redirect_to @game
  end

  def destroy
    supporter = @game.supporters.find params[:id]
    supporter.destroy
    redirect_to @game
  end

private
  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_and_authorize_game
    set_game
    authorize! :create_supporter, @game
  end

  def supporter_params
    params.require(:supporter).permit(:user)
  end
end
