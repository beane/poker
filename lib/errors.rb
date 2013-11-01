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