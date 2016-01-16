require 'spec_helper'

RSpec.describe TextMasterShop::Cart do
  it 'adds items' do
    item = double(:item, id: 1, price_in_pennies: 1_000)
    cart = described_class.new

    cart.add(item)

    expect(cart.total).to eq(1_000)
  end

  it 'adds items with quantities' do
    item = double(:item, id: 1, price_in_pennies: 1)
    cart = described_class.new

    cart.add(item, quantity: 3)

    expect(cart.quantity(item)).to eq(3)
  end

  it 'increments quantities of items' do
    item = double(:item, id: 1, price_in_pennies: 1)
    cart = described_class.new

    cart.add(item)
    cart.increment(item)

    expect(cart.quantity(item)).to eq(2)
  end

  it 'decrements quantities of items' do
    item = double(:item, id: 1, price_in_pennies: 1)
    cart = described_class.new

    cart.add(item)
    cart.increment(item)
    cart.decrement(item)

    expect(cart.quantity(item)).to eq(1)
  end

  it 'removes items' do
    item = double(:item, id: 1, price_in_pennies: 1_000)
    cart = described_class.new

    cart.add(item)
    cart.remove(item)

    expect(cart.total).to eq(0)
  end
end
