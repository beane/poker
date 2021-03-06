# encoding: UTF-8
require 'rspec'
require 'poker'

describe Card do
  subject(:card) { Card.new(13, :heart) }

  it 'has a value' do
    expect(card.value).not_to be nil
  end

  it 'has a suit' do
    expect(card.suit).not_to be nil
  end

  it 'only has legit suits' do
    expect { Card.new(10, :stark) }.to raise_error(NoSuitError)
  end

  it 'only has legit values' do
    expect { Card.new(76, :heart) }.to raise_error(NoValueError)
  end

  it 'displays a string' do
    expect(card.display).to be_an_instance_of(String)
  end

end