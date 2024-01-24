# app/controllers/holes_controller.rb

class HolesController < ApplicationController
  before_action :find_round, only: [:new, :create]

  def new
    @hole = @round.holes.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @hole = @round.holes.create(hole_params)
    respond_to do |format|
      format.html { redirect_to round_path(@round) }
      format.js
    end
  end

  private

  def find_round
    @round = Round.find(params[:round_id])
  end

  def hole_params
    params.require(:hole).permit(:number, :score)
  end
end
