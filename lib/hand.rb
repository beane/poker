require_relative 'deck'
class Hand

  attr_reader :cards

  def initialize(cards) # just an array of cards
    @cards = cards
  end

  def rank
    best_card = card_values.max
    return {:best_hand => :straight_flush} if is_straight_flush?
    return {:best_hand => :four} if is_four?
    return {:best_hand => :full_house} if is_full_house?
    return {:best_hand => :flush} if is_flush?
    return {:best_hand => :straight} if is_straight?
    return {:best_hand => :three} if is_three?
    return {:best_hand => :two_pair} if is_two_pair?
    return {:best_hand => :pair} if is_pair?

    {:best_hand => :high_card, :best_card => best_card}
  end

  def <=>(other_hand)

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
    actual_card_values = card_values
    normalized_card_values = actual_card_values.map do |val|
      new_val = val if val < 14
      new_val = 1 if val == 14
      new_val
    end
    return true if is_normalized_straight?(actual_card_values)
    is_normalized_straight?(normalized_card_values)
  end

  def is_normalized_straight?(card_values)
    return false unless card_values.max - card_values.min == 4
    card_values.uniq.size > 4
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











