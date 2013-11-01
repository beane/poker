require_relative 'deck'
class Hand

  HAND_VALUES = {
                  :straight_flush => 9,
                  :four => 8,
                  :full_house => 7,
                  :flush => 6,
                  :straight => 5,
                  :three => 4,
                  :two_pair => 3,
                  :pair => 2,
                  :high_card => 1
                }

  attr_reader :cards

  def initialize(cards) # just an array of cards
    @cards = cards
  end

  def rank
    return :straight_flush if is_straight_flush?
    return :four if is_four?
    return :full_house if is_full_house?
    return :flush if is_flush?
    return :straight if is_straight?
    return :three if is_three?
    return :two_pair if is_two_pair?
    return :pair if is_pair?

    :high_card
  end

  def <=>(other_hand)
    comparison = HAND_VALUES[rank] <=> HAND_VALUES[other_hand.rank]
    return comparison unless comparison == 0


  end

  private

  def nth_highest_relevant_card(n)
    value_repeats.sort_by { |key, value| value }[-n][0]
  end

  def is_straight_flush?
    is_straight? && is_flush?
  end

  def is_four?
    value_repeats.values.include?(4)
  end

  def is_full_house?
    value_repeats.values.sort == [2,3]
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
    value_repeats.values.include?(3)
  end

  def is_two_pair?
    value_repeats.values.select { |freq| freq == 2 }.size == 2
  end

  def is_pair?
    value_repeats.values.include?(2)
  end

  def value_repeats
    value_count = Hash.new(0)
    self.cards.each do |card|
      value_count[card.value] += 1
    end

    value_count
  end

  def card_values
    @cards.map { |card| card.value }.sort
  end

end











