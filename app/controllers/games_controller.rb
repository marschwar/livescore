class GamesController < ApplicationController
  before_action :set_and_authorize_game, only: [:edit, :edit_score, :update, :update_score, :destroy]
  before_action :set_game, only: [:show, :scoreboard, :notes, :widget]

  skip_before_action :force_https, only: :widget
  after_action :allow_iframe, only: :widget

  # GET /games
  # GET /games.json
  def index
    team_name = params[:team_name]
    team = Team.is_like(team_name).first if team_name.present?
    if team
      redirect_to team_path(team)
    end

    @show_jumbo = anonymous and request.path == '/'
    @games = Game.relevant.order(updated_at: :desc )
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @notes = @game.notes.recent 25
    @comments = @game.comments.recent 25
    if can? :create_supporter, @game
      @supporter = Supporter.new
    end
    if can? :create_comment, @game
      @comment = Comment.new
    end
  end

  def scoreboard
    respond_to do |format|
      format.html { render layout: 'plain' }
      format.jpg {
        img = generate_scoreboard_image
        send_data img, type: 'image/jpg', disposition: 'inline'
      }
    end
  end

  def widget
    @theme = widget_params[:theme] || :default
    render 'widget', layout: 'widget'
  end

  # GET /games/new
  def new
    @game = Game.new
    @game.game_day = Date.today
    @game.game_time = '15:00'
  end

  # GET /games/1/edit
  def edit
  end

  # GET /games/1/edit_score
  def edit_score
    @period_options = []
    Game::PERIODS.each do |key|
      @period_options << [ t("activerecord.values.game.period.#{key}"), key ]
    end
  end

  # POST /games
  # POST /games.json
  def create
    p = game_params

    home_team_name = p.delete(:home_team_name)
    away_team_name = p.delete(:away_team_name)
    p[:home_team_id] = find_or_create_team(home_team_name).try(:id)
    p[:away_team_id] = find_or_create_team(away_team_name).try(:id)

    @game = Game.new(p)
    @game.user = current_user
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, notice: 'Game was successfully created.' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    p = game_params

    p[:home_team_id] = find_or_create_team(p.delete(:home_team_name)).try(:id) if p[:home_team_name].present?
    p[:away_team_id] = find_or_create_team(p.delete(:away_team_name)).try(:id) if p[:away_team_name].present?

    respond_to do |format|
      if @game.update(p)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  def set_and_authorize_game
    set_game
    authorize! action_name.to_sym, @game
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(
      :home_team_id, :home_team_name,
      :away_team_id, :away_team_name,
      :home_quarter_1, :home_quarter_2, :home_quarter_3, :home_quarter_4,
      :away_quarter_1, :away_quarter_2, :away_quarter_3, :away_quarter_4,
      :period, :possession,
      :location,
      :game_day, :game_time
    )
  end

  def widget_params
    params.permit(:theme)
  end

  def anonymous
    current_user.blank?
  end

  def find_or_create_team(team_name)
    team = Team.find_or_create_by(name: team_name) if team_name
  end

  def generate_scoreboard_image
    html =  render_to_string('scoreboard', layout: 'plain', formats: [:html])
    IMGKit.new(html, width: 400, height: 400).to_img
  end
end
