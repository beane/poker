require 'rspec'
require 'deck'

describe Deck do

  subject(:deck) { Deck.new }
  let(:shuffled_deck) { Deck.new.shuffle }

  describe "#initialize" do
    it "has 52 cards" do
      expect(deck.cards.size).to eq(52)
    end

    it 'all the cards should be different' do
      expect(deck.cards.uniq.size).to eq(52)
    end
  end

  describe "#shuffle" do
    it 'shuffles the deck' do
      expect(deck.cards).not_to eq(shuffled_deck)
    end

    it 'still has 52 cards' do
      expect(deck.shuffle.cards.size).to eq(52)
    end
  end

  describe "#deal" do

    let(:bottom_card) { deck.cards.last }

    before(:each) do
      deck.deal(5)
    end

    it 'shrinks the deck by right number' do
      expect(deck.cards.size).to eq(47)
    end

    it 'returns an array of cards' do
      expect(deck.deal(5).all?{ |card| card.is_a?(Card) }).to be true
    end

    it 'returns the right number of cards' do
      expect(deck.deal(5).size).to eq(5)
    end

    it 'returns only the top cards' do
      expect(bottom_card).to be(deck.cards.last)
    end

    it 'raises error if out of cards' do
      expect { deck.deal(48) }.to raise_error(OutOfCardsError)
    end
  end
end