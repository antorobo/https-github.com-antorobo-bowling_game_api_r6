class GamesController < ApplicationController
  def index
    games = Game.order('created_at DESC')
    render json: {status:'SUCCESS', message:'Loaded Games', data:games}, status: :ok
  end
  def show
    game = Game.find(params[:id])
    render json: {status: 'SUCCESS', message: 'Loaded game', data: game},status: :ok
  end
  def create
    game = Game.new(game_params)
    if game.save
      render json: {status: 'SUCCESS', message:'game Saved', data:game}, status: :ok
    else
      render json: {status: 'ERROR', message:'game NOT Saved', data:game.errors}, status: :unprocessable_entity
    end
  end

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

  private
  def game_params
  end
end