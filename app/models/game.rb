class Game < ApplicationRecord
  include GameHelper

  def initialize(args)
    @difficulty = args[:difficulty]
  end

  def build_deck
    deck = []

    4.times do |i = 0| # This iterates over the 4 decks as defined in the game.rb model.
      a = arrays_and_quantities[hash_array_keys[i]]
      q = arrays_and_quantities[hash_quantity_keys[i]]

      # The random (numbers) array is used to ensure only one of each card is dealt.
      ra = []
      n = 0

      until n == q do
        rn = rand(a.length)

        unless ra.include? rn # Ensure the random number hasn't already been used before.
          deck.push(a[rn])

          ra.push(rn)
          n = n+1
        end
      end

    end

    # Generate 'pairs' of cards.
    deck = deck + deck

    return deck.shuffle!
  end
end
