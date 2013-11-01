require 'rspec'
require 'hand'

describe Hand do

  describe '#initialize' do

    subject(:hand) { Hand.new }

    it 'should have five cards' do
      expect(hand.cards.size).to eq(5)
    end

    it 'should be only cards' do
      expect(hand.cards.all? { |card| card.is_a?(Card) } ).to be true
    end
  end
end