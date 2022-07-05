class GameController < ApplicationController
  include GameHelper

  def index
    # @game = Game.new({ difficulty: "normal" })
    # @deck = @game.build_deck

    # @deck = Game.new({ difficulty: "normal" }).build_deck
    @difficulty = params[:difficulty] || 'normal'
    @deck = Game.new({ difficulty: @difficulty }).build_deck
    render "game/index", title: 'Shattered View: A Novel on Rails'
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

end
