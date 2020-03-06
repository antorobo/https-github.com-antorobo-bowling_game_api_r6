require 'pry'
class ThrowsController < ApplicationController
  #before_action :set_game
  #before_action :set_throw, only: [:show, :update, :destroy]

  # GET /throws
  def index
    game = Game.find(params[:game_id])
    throws = game.throws
    render json: throws
    #render json: {status:'SUCCESS', message:'Loaded Throws', data:throws}, status: :ok
  end

  # GET /throws/1
  def show
    game = Game.find(params[:game_id])
    throw = game.throws.find(params[:id])
    #binding.pry
    render json: throw
  end

  # POST /throws
  def create
    game = Game.find(params[:game_id])
    throw = game.throws.build(throw_params)

    if throw.save
      render json: {status: 'SUCCESS', message: 'Throw Saved', data:throw}, status: :created
    else
      render json: throw.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /throws/1
  #def update
    #if throw.update(throw_params)
      #render json: throw
    #else
      #render json: throw.errors, status: :unprocessable_entity
    #end
  #end

  # DELETE /throws/1
  #def destroy
    #throw.destroy
  #end

  private

#    def set_game
#      #binding.pry
#      game = Game.find(params[:game_id])
#    end
#    # Use callbacks to share common setup or constraints between actions.
#    def set_throw
#      throw = game.throws.find(params[:id])
#    end

    # Only allow a trusted parameter "white list" through.
    def throw_params
      params.require(:throw).permit(:pins, :game_id)
    end
end
