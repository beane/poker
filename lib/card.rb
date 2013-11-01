# encoding: UTF-8
require_relative 'errors'
class Card

  DISPLAY_VALUE = {
                    11 => 'J',
                    12 => 'Q',
                    13 => 'K'
                  }

  DISPLAY_SUIT = {
                  :heart => "♡",
                  :diamond => "♢",
                  :club => "♣",
                  :spade => "♠"
                }

  attr_reader :value, :suit

  def initialize(value, suit)
    raise NoSuitError unless DISPLAY_SUIT.keys.include?(suit)
    raise NoValueError unless (1..13).include?(value)
    @value, @suit = value, suit
  end
end