class Game
  attr_reader :players, :deck
  def initialize(deck = nil, num_players)
    @deck = deck || Deck.new
    @players = []
    num_players.times do
      @players << Player.new
    end
  end
  
  def play
    @deck.shuffle
    deal
    swap
    players.each_with_index do |player, index|
      p player.hand
      puts "Player #{index + 1}: #{player.hand.rank}"
    end
    
    winner = find_winner
    winner_index = players.index(winner)
    puts "Player #{winner_index + 1} wins!"
  end
  
  private

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
  
    def find_winner
      players.sort_by { |player| player.hand }.last
    end
end
