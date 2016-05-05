class NotesController < ApplicationController
  before_action :set_and_authorize_game, only: [:new, :create]
  before_action :set_game, only: [:index, :destroy]

  skip_before_action :force_https, only: :widget
  after_action :allow_iframe, only: :widget

  # GET /games/:game_id/notes/new
  def new
    @note = Note.new
    @note.game = @game
  end

  def index
    @notes = @game.notes.order(created_at: :desc)
    if request.xhr?
      render partial: 'notes', locals: { game: @game, notes: @notes }
    end
  end

  def widget
    @game = Game.find(params[:id])
    @notes = @game.notes.order(created_at: :desc)
    @theme = widget_params[:theme] || :default

    render 'widget', layout: 'widget'
  end

  def destroy
    authorize! :destroy_note, @game
    @note = @game.notes.find params[:id]
    @note.try(:destroy)

    redirect_to game_path(@game)
  end

  # POST /games/:game_id/notes
  # POST /games/:game_id/notes.json
  def create
    @note = Note.new(note_params)
    @note.game = @game
    respond_to do |format|
      if @note.save
        format.html { 
          if params[:source] == 'quick'
            redirect_to edit_quick_game_path(@game), notice: 'Note was successfully created.' 
          else
            redirect_to @game, notice: 'Note was successfully created.' 
          end
        }
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

  def widget_params
    params.permit(:theme)
  end
end
