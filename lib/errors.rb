class NoSuitError < ArgumentError
  def message
    "Invalid card symbol. (Must be singular.)"
  end
end

class NoValueError < ArgumentError
  def message
    "Card value out of bounds. Must be 1-13"
  end
end

class OutOfCardsError < StandardError
  def message
    "All 52 cards have been dealt"
  end
end