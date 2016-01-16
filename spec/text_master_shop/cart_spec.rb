require 'spec_helper'

RSpec.describe TextMasterShop::Cart do
  it 'adds items' do
    item = double(:item, id: 1)
    cart = described_class.new

    cart.add(item)

    expect(cart.find(type: 'RSpec::Mocks::Double', id: 1)).not_to be_nil
  end

  it 'adds items with quantities' do
    item = double(:item, id: 1)
    cart = described_class.new

    cart.add(item, quantity: 3)

    expect(cart.quantity(item)).to eq(3)
  end

  it 'increments quantities of items' do
    item = double(:item, id: 1)
    cart = described_class.new

    cart.add(item)
    cart.increment(item)

    expect(cart.quantity(item)).to eq(2)
  end

  it 'decrements quantities of items' do
    item = double(:item, id: 1)
    cart = described_class.new

    cart.add(item)
    cart.increment(item)
    cart.decrement(item)

    expect(cart.quantity(item)).to eq(1)
  end

  it 'removes items' do
    item = double(:item, id: 1)
    cart = described_class.new

    cart.add(item)
    cart.remove(item)

    expect(cart.find(type: 'Rspec::Mocks::Double', id: 1)).to be_nil
  end
end
