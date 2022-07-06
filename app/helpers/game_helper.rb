module GameHelper
  def decks
    {
      :alphabet => %w[a b c d e f g h i j k l m n o p q r s t u v w x y z],
      :shapes => %w[circle square triangle],
      :operators => %w[! + * % & ?],
      :icons => %w[🍑 🍆 ❤️ 💩 😄 🦊 🍤 🦄 🌈 🧠 🦕]
    }
  end

  def quantity_of_cards
    if @difficulty == 'hard'
      { alphabet_quantity: 8, shapes_quantity: 3, operators_quantity: 1, icons_quantity: 8, total_quantity: 20 }
    elsif @difficulty == 'normal'
      { alphabet_quantity: 3, shapes_quantity: 2, operators_quantity: 1, icons_quantity: 4, total_quantity: 10 }
    else
      # difficulty == 'easy'
      { alphabet_quantity: 1, shapes_quantity: 1, operators_quantity: 1, icons_quantity: 2, total_quantity: 5 }
    end
  end

  def arrays_and_quantities
    d = decks
    q = quantity_of_cards
    {
      aa: d[:alphabet], aq: q[:alphabet_quantity],
      sa: d[:shapes], sq: q[:shapes_quantity],
      oa: d[:operators], oq: q[:operators_quantity],
      ia: d[:icons], iq: q[:icons_quantity],
    }
  end

  def hash_array_keys
    [:aa, :sa, :oa, :ia]
  end

  def hash_quantity_keys
    [:aq, :sq, :oq, :iq]
  end

end
