# encoding: UTF-8
require 'colorize'
require_relative 'errors'
class Card

  DISPLAY_VALUE = {
    11 => 'J',
    12 => 'Q',
    13 => 'K',
    1 => 'A'
  }

  DISPLAY_SUIT = {
    :heart => "♥",
    :diamond => "♦",
    :club => "♣",
    :spade => "♠"
  }

  SUIT_COLOR = {
    :heart => :red,
    :diamond => :red,
    :black => :black,
    :black => :black
  }

  attr_reader :value, :suit

  def initialize(value, suit)
    raise NoSuitError unless DISPLAY_SUIT.keys.include?(suit)
    raise NoValueError unless (1..13).include?(value)
    @value, @suit = value, suit
  end

  def display
    color = SUIT_COLOR[self.suit]
    display = DISPLAY_SUIT[self.suit]
    if self.value.between?(2,10)
      display += self.value
    else
      display += DISPLAY_VALUE[self.value]
    end

    display += DISPLAY_SUIT[self.suit]
    display.colorize(:color=>color, :background => :white)
  end

end

puts Card.new(1, :spade).display