class Hand
  
  include Comparable

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

  def rank # checks in descending winning order
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

  # returns -1 if it beats the other hand, 1 if it loses, 0 if tied
  def <=>(other_hand)
    comparison = HAND_VALUES[rank] <=> HAND_VALUES[other_hand.rank]
    return comparison unless comparison == 0

    # only gets here if they're of equal rank
    # time to compare the relevant high cards
    count = 1
    loop do
      new_comparison = compare_high_cards(other_hand, count)
      
      # keeps trying if those two cards are equal
      return new_comparison unless new_comparison == 0
      
      count += 1
      
      return 0 if count == 5 # the hands are of equal value
    end
  end
  
  def to_s
    cards.map { |card| card.display }.join(',')
  end

  protected
  
    def compare_high_cards(other_hand, n)
      nth_highest_relevant_card(n) <=> other_hand.nth_highest_relevant_card(n)
    end
  
    # finds the highest card that is relevant to comparison
    # for example: (4,4,4,3,3) beats (3,3,3,A,A) even though
    # aces are the highest-scoring card
    # returns the nth most frequently occuring value
    def nth_highest_relevant_card(n)
      value_repeats.sort_by { |key, value| value }[-n][0]
    end

  private
  
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
    
      self.cards.each { |card| suit_count[card.suit] += 1 }

      suit_count.values.include?(5)
    end

    def is_straight?
      ace_high_card_values = card_values # assumes ace is 14
    
      ace_low_card_values = ace_high_card_values.map do |val|
        new_val = val if val < 14
        new_val = 1 if val == 14
        new_val
      end
    
      # checks if it's a straight with ace high,
      # otherwise checks with ace low
      return true if is_normalized_straight?(ace_high_card_values)
    
      is_normalized_straight?(ace_low_card_values)
    end

    def is_normalized_straight?(card_values)
      return false unless card_values.max - card_values.min == 4
      card_values.uniq.size == 5
    end

    def is_three?
      value_repeats.values.include?(3)
    end

    # returns true if there are two values which each appear twice
    def is_two_pair?
      value_repeats.values.select { |freq| freq == 2 }.size == 2
    end

    def is_pair?
      value_repeats.values.include?(2)
    end

    def value_repeats
      value_count = Hash.new(0)
    
      self.cards.each { |card| value_count[card.value] += 1 }

      value_count
    end

    def card_values
      @cards.map { |card| card.value }.sort
    end
end