class ChampionshipsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :join, :create]
  
  def index
    @championships = Championship.all
  end

  def show
    @championship = Championship.find(params[:id])
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

    redirect_to root_path, notice: 'Te has unido al campeonato exitosamente.'
  end

  private

  def championship_params
    params.require(:championship).permit(:name)
  end
end
  