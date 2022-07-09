class GameController < ApplicationController
  include GameHelper

  def index
    # @game = Game.new({ difficulty: "normal" })
    # @deck = @game.build_deck

    # @deck = Game.new({ difficulty: "normal" }).build_deck
    @difficulty = params[:difficulty] || 'normal'
    @deck = Deck.new({ difficulty: @difficulty }).build_deck
  end

  def save
    @game = Game.new( game_params )

    respond_to do |format|
      if @game.save
        format.json { render json: @game, message: "The game was saved successfully." }
      else
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def scores
    @scores = [
      { name: 'Ewan McLean',
        turns: '20',
        level: 'normal',
        time: '1:10' },
      { name: 'Danielle Matson',
        turns: '23',
        level: 'normal',
        time: '1:30' },
      { name: 'Kevin Kurpe',
        turns: '26',
        level: 'normal',
        time: '1:50' },
      { name: 'Matthew Grote',
        turns: '30',
        level: 'normal',
        time: '3:20' },
      { name: 'Michael Kurpe',
        turns: '35',
        level: 'normal',
        time: '3:30' }
    ]
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.permit(:name, :game_board, :score, :time, :points_recall, :points_blind, :turns)
  end
end
