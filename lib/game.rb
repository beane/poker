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
    
  end
end