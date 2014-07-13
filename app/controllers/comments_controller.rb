class CommentsController < ApplicationController
  before_action :set_and_authorize_game, only: [ :create ]

  # POST /games/:game_id/comments
  # POST /games/:game_id/comments.json
  def create
    @comment = Comment.new comments_params
    @comment.tap do |c|
      c.user = current_user
      c.game = @game
    end
    @comment.save

    redirect_to @game
  end

private
  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_and_authorize_game
    set_game
    authorize! :create_comment, @game
  end

  def comments_params
    params.require(:comment).permit(:text)
  end
end
