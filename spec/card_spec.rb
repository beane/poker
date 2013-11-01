# encoding: UTF-8
require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(13, :hearts) }

  it 'has a value' do
    expect(card.value).to be truthy
  end

  it 'has a suit' do
    expect(card.suit).to be truthy
  end

  it 'only has legit suits' do
    expect { Card.new(10, :starks) }.to raise_error(NoSuitError)
  end

  it 'only has legit values' do
    expect { Card.new(76, :hearts) }.to raise_error(NoValueError)
  end

  it 'displays a unicode card' do
    expect(card.display).to eq "♡K♡"
  end

end