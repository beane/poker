class Deck
  attr_reader :cards

  def initialize
    @cards = []
    
    (2..14).each do |value|
      Card::DISPLAY_SUITS.keys.each do |suit|
        @cards << Card.new(value, suit)
      end
    end
  end

  def shuffle
    @cards.shuffle!
    self
  end

  def deal(num_cards)
    raise OutOfCardsError if num_cards > self.cards.size
    
    new_cards = cards.take(num_cards)
    @cards = cards.drop(num_cards)

    new_cards
  end
  
  def return_cards(cards)
    @cards.push(cards)
  end
  
  def swap(cards)
    return_cards(cards)
    deal(cards.size)
  end
end
