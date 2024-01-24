class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]

  def index
    @teams = Team.all
  end

  def show
  end

  def new
    @team = Team.new
    @championship = Championship.find(params[:championship_id])
  end

  def edit
  end

  def join
    @team = Team.find(params[:id])

    unless current_user.teams.exists?(id: @team.id)
      current_user.teams << @team
      flash[:notice] = 'Te has unido al equipo exitosamente.'
    end

    redirect_back fallback_location: root_path
  end

  def create
    @team = Team.new(team_params)
    @championship = Championship.find_by(id: params[:team][:championship_id])
  
    if @championship.nil?
      redirect_to root_path, alert: 'Championship not found'
      return
    end
  
    respond_to do |format|
      if @team.save
        current_user.teams << @team
        format.html { redirect_to championship_path(@championship), notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to edit_team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def leave
    championship_id = params[:championship_id]
    team_id = params[:id]
  
    puts "Championship ID: #{championship_id}"
    puts "Team ID: #{team_id}"
  
    if current_user.leave_team(team_id)
      redirect_to championship_path(championship_id), notice: 'Has dejado el equipo exitosamente.'
    else
      redirect_to championship_path(championship_id), alert: 'Error al intentar dejar el equipo.'
    end
  end
  
  def start_round
    team = Team.find(params[:id])
    if team.users.count >= 2
      round = Round.create(team: team, date: Date.today) 
      redirect_to round, notice: 'Round started successfully.'
    else
      redirect_to team, alert: 'Cannot start round. Team must have at least 2 members.'
    end
  end

  private

    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :championship_id)
    end
end
