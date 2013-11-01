require 'rspec'
require 'deck'

describe Deck do

  subject(:deck) { Deck.new }
  let(:shuffled_deck) { Deck.new.shuffle }

  describe "#initialize" do
    it "should have 52 cards" do
      expect(deck.cards.size).to eq(52)
    end

    it 'all the cards should be different' do
      expect(deck.cards.uniq.size).to eq(52)
    end
  end

  describe "#shuffle" do
    it 'should shuffle the deck' do
      expect(deck.cards).not_to eq(shuffled_deck)
    end

    it 'should still have 52 cards' do
      expect(deck.shuffle.cards.size).to eq(52)
    end
  end

  describe "#deal" do

    let(:bottom_card) { deck.cards.last }

    before(:each) do
      deck.deal(5)
    end

    it 'should shrink the deck by right number' do
      expect(deck.cards.size).to eq(47)
    end

    it 'should return an array of cards' do
      expect(deck.deal(5).all?{ |card| card.is_a?(Card) }).to be true
    end

    it 'should return the right number of cards' do
      expect(deck.deal(5).size).to eq(5)
    end

    it 'should return only the top cards' do
      expect(bottom_card).to be(deck.cards.last)
    end

    it 'should raise error if out of cards' do
      expect { deck.deal(48) }.to raise_error(OutOfCardsError)
    end
  end
end