require_relative 'deck'
class Hand

  attr_reader :cards

  def initialize(cards) # just an array of cards
    @cards = cards
  end

  def rank

  end

  private

  def is_straight_flush?
    is_straight? && is_flush?
  end

  def is_four?
    value_repeats.include?(4)
  end

  def is_full_house?
    value_repeats == [2,3]
  end

  def is_flush?
    suit_count = Hash.new(0)
    self.cards.each do |card|
      suit_count[card.suit] += 1
    end

    suit_count.values.include?(5)
  end

  def is_straight?
    return false unless card_values.max - card_values.min == 4
    card_values.uniq.size == 5
  end

  def is_three?
    value_repeats.include?(3)
  end

  def is_two_pair?
    value_repeats.select { |freq| freq == 2 }.size == 2
  end

  def is_pair?
    value_repeats.include?(2)
  end

  def value_repeats
    value_count = Hash.new(0)
    self.cards.each do |card|
      value_count[card.value] += 1
    end

    value_count.values.sort
  end

  def card_values
    @cards.map { |card| card.value }.sort
  end

end











