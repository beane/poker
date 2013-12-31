class Game
  attr_reader :players, :deck
  def initialize(deck = nil, num_players)
    @deck = deck || Deck.new
    @players = []
    num_players.times do
      @players << Player.new
    end
  end
  
  def deal
    players.each do |player|
      player.new_hand(deck.deal(5))
    end
  end
  
  def swap
    players.each do |player|
      cards = player.prompt_drop
      player.add_to_hand(deck.deal(cards.size))
    end
  end
end