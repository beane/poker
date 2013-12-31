class Player
  attr_reader :hand
  
  def initialize
    @hand
  end
  
  def new_hand(cards)
    @hand = Hand.new(cards)
  end
  
  def add_to_hand(cards)
    @hand += cards
  end
  
  def drop(cards)
    cards.each do |card|
      @hand.delete(card)
    end
    
    cards
  end
  
  def prompt_drop
    begin
      p @hand
      puts "Give the indices of the cards you want to drop."
      indices = gets.chomp.split(',').map(&:to_i).uniq

      if @hand.cards.map(&:value).include?(14)
        raise TooManyCardsError if indices.size > 4
      else
        raise TooManyCardsError if indices.size > 3
      end

    rescue TooManyCardsError => e
      puts e.message
      puts "Try again."
      retry
    end
    
    cards_to_drop = []
    indices.each do |index|
      cards_to_drop << @hand.cards[index]
    end
    
    drop(cards_to_drop)
  end
end
