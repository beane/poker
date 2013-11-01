require_relative 'deck'
class Hand

  attr_reader :cards

  def initialize(cards) # just an array of cards
    @cards = cards
  end
end