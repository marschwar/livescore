class NotesController < ApplicationController
  before_action :set_and_authorize_game, only: [:new, :create]

  # GET /games/:game_id/notes/new
  def new
    @note = Note.new
    @note.game = @game
  end

  # POST /games/:game_id/notes
  # POST /games/:game_id/notes.json
  def create
    @note = Note.new(note_params)
    @note.game = @game
    respond_to do |format|
      if @note.save
        format.html { redirect_to @game, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_and_authorize_game
    set_game
    authorize! :create_note, @game
  end

  def note_params
    params.require(:note).permit(:text)
  end
end
