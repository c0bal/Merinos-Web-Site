class ChampionshipsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :join, :create]
  
  def index
    @championships = Championship.all
  end

  def show
    @championship = Championship.find(params[:id])
    @championship_teams = @championship.teams.includes(:round).sort_by { |team| team.round&.score.to_i }.reverse

  end

  def new
    @championship = Championship.new
  end

  def create
    @championship = current_user.championships.build(championship_params)

    if @championship.save
      redirect_to @championship, notice: 'Championship was successfully created.'
    else
      render :new
    end
  end
  # Otras acciones del controlador

  def join
    @championship = Championship.find(params[:id])
    current_user.championships << @championship
  
    respond_to do |format|
      format.html { redirect_to championship_path(@championship.id), notice: 'Te has unido al campeonato exitosamente.' }
    end
  end

  def start
    @championship = Championship.find(params[:id])
    @championship.update(estado: 'en_progreso')
    redirect_to championship_path(@championship.id), notice: 'Campeonato iniciado exitosamente.'
  end

  def stop
    @championship = Championship.find(params[:id])
    @championship.update(estado: 'finalizado')
    redirect_to championships_path, notice: 'Campeonato finalizado exitosamente.'
  end

  private

  def championship_params
    params.require(:championship).permit(:name, :estado)
  end
end
  