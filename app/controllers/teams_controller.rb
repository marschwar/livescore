class TeamsController < ApplicationController
  include EntityImage

  before_action :set_and_authorize_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    authorize! :index, Team
    respond_to do |format|
      format.json do
        query = params[:q] || ''
        team_names = Team.is_like(query).map &:name
        render json: team_names
      end
      format.html { @teams = Team.all }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @years = Game.with_team(@team).order(game_day: :desc ).group_by {|g| g.game_day.year}

    respond_to do |format|
      format.png { send_team_image :png }
      format.jpg { send_team_image :jpeg }
      format.html { }
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    if Game.where('away_team_id = ? or home_team_id = ?', @team, @team).count == 0
      @team.destroy
      respond_to do |format|
        format.html { redirect_to teams_url }
        format.json { head :no_content }
      end
    else
      flash[:error] = 'Es gibt bereits Spiele für dieses Team'
      redirect_to team_path @team
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.friendly.find(params[:id])
  end

  def set_and_authorize_team
    set_team
    authorize! action_name.to_sym, @team
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :logo)
  end

  def send_team_image(type)
    send_image @team.raw_image_data, type
  end
end
