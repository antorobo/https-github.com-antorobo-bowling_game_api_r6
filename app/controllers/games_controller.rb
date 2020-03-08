class GamesController < ApplicationController
  def index
    render json: games = Game.order('created_at DESC')
  end
  def show
    game = Game.find(params[:id])
    render json: game.scoreboard
  end
  def create
    game = Game.new(game_params)
    if game.save
      render json: {status: 'SUCCESS', message:'Game started- Please use game id', data:game}, status: :ok
    else
      render json: {status: 'ERROR', message:'game NOT Saved', data:game.errors}, status: :unprocessable_entity
    end
  end
=begin
  def destroy
    game = Game.find(params[:id])
    game.destroy
    render json: {status: 'SUCCESS', message:'game Deleted', data:game}, status: :ok
  end

  def update
    game = Game.find(params[:id])
    if game.update_attributes(game_params)
      render json: {status: 'SUCCESS', message:'game Updated', data:game}, status: :ok
    else
      render json: {status: 'ERROR', message:'game NOT Updated', data:game.errors}, status: :unprocessable_entity
    end
  end
=end
  private
  def game_params
  end
end