require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    (1..13).each do |value|
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
    new_cards = @cards.take(num_cards)
    @cards = @cards.drop(num_cards)

    new_cards
  end

end