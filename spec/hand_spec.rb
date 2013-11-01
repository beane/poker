require 'rspec'
require 'hand'

describe Hand do
  let(:deck) { double("deck", :deal => [
                        Card.new(10,:heart),
                        Card.new(4, :spade),
                        Card.new(3, :diamond),
                        Card.new(14, :diamond),
                        Card.new(9, :club) ] )
              }

  let(:high_card_hand) { Hand.new(deck.deal) }

  let(:pair_hand) { Hand.new([
                          Card.new(10,:heart),
                          Card.new(10,:spade),
                          Card.new(3, :diamond),
                          Card.new(14, :diamond),
                          Card.new(9, :club) ])
                        }

  let(:two_pair_hand) { Hand.new([
                          Card.new(10,:heart),
                          Card.new(10,:spade),
                          Card.new(3, :diamond),
                          Card.new(3, :club),
                          Card.new(9, :club) ])
                        }

  let(:other_two_pair_hand) { Hand.new([
                          Card.new(10,:spade),
                          Card.new(10,:heart),
                          Card.new(3, :club),
                          Card.new(3, :heart),
                          Card.new(11, :club) ])
                        }

  let(:three_hand) { Hand.new([
                          Card.new(10,:heart),
                          Card.new(10,:spade),
                          Card.new(10, :diamond),
                          Card.new(3, :club),
                          Card.new(9, :club) ])
                        }

  let(:straight_hand) { Hand.new([
                          Card.new(14,:heart),
                          Card.new(5,:spade),
                          Card.new(2, :diamond),
                          Card.new(3, :club),
                          Card.new(4, :club) ])
                        }

  let(:straight_ace_hand) { Hand.new([
                        Card.new(10,:heart),
                        Card.new(11,:spade),
                        Card.new(12, :diamond),
                        Card.new(13, :club),
                        Card.new(14, :club) ])
                        }

  let(:flush_hand) { Hand.new([
                          Card.new(10,:club),
                          Card.new(3,:club),
                          Card.new(8, :club),
                          Card.new(7, :club),
                          Card.new(2, :club) ])
                        }

  let(:full_house_hand) { Hand.new([
                          Card.new(10,:club),
                          Card.new(2,:heart),
                          Card.new(10, :heart),
                          Card.new(10, :diamond),
                          Card.new(2, :club) ])
                        }

  let(:four_hand) { Hand.new([
                          Card.new(10,:club),
                          Card.new(10,:heart),
                          Card.new(10, :diamond),
                          Card.new(10, :heart),
                          Card.new(3, :club) ])
                        }

  let(:other_four_hand) { Hand.new([
                          Card.new(11,:club),
                          Card.new(11,:heart),
                          Card.new(11, :diamond),
                          Card.new(11, :heart),
                          Card.new(2, :club) ])
                        }

  let(:straight_flush_hand) { Hand.new([
                          Card.new(10,:club),
                          Card.new(9,:club),
                          Card.new(8, :club),
                          Card.new(11, :club),
                          Card.new(7, :club) ])
                        }

  describe '#initialize' do

    it 'should have five cards' do
      expect(high_card_hand.cards.size).to eq(5)
    end

    it 'should be only cards' do
      expect(high_card_hand.cards.all? { |card| card.is_a?(Card) } ).to be true
    end
  end

  describe '#rank' do
    it 'should evaluate high card' do
      expect(high_card_hand.rank[:best_hand]).to eq(:high_card)
    end

    it 'should evaluate pair' do
      expect(pair_hand.rank[:best_hand]).to eq(:pair)
    end

    it 'should evaluate two pair' do
      expect(two_pair_hand.rank[:best_hand]).to eq(:two_pair)
    end

    it 'should evaluate three of a kind' do
      expect(three_hand.rank[:best_hand]).to eq(:three)
    end

    it 'should evaluate straight' do
      expect(straight_hand.rank[:best_hand]).to eq(:straight)
    end

    it 'should evaluate flush' do
      expect(flush_hand.rank[:best_hand]).to eq(:flush)
    end

    it 'should evaluate full house' do
      expect(full_house_hand.rank[:best_hand]).to eq(:full_house)
    end

    it 'should evaluate four of a kind' do
      expect(four_hand.rank[:best_hand]).to eq(:four)
    end

    it 'should evaluate straight flush' do
      expect(straight_flush_hand.rank[:best_hand]).to eq(:straight_flush)
    end
  end

  describe '#compare' do
    it 'correctly finds simple winning hands' do
      expect(straight_flush_hand <=> flush_hand).to eq(1)
      expect(two_pair_hand <=> straight_hand).to eq(-1)
      expect(four_hand <=> full_house).to eq(1)
    end

    it 'correctly compares hands of same rank' do
      expect(four_hand <=> other_four_hand).to eq(1)
    end

    it 'correctly uses high card to compare hands' do
      expect(two_pair_hand <=> other_two_pair_hand).to eq(1)
    end

    it 'evaluates aces correctly' do
      # ace high ace low in straight and high card
    end
  end
end