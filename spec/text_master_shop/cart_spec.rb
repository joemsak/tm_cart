require 'spec_helper'

RSpec.describe TextMasterShop::Cart do
  it 'adds items' do
    item = double(:item, id: 1, price_in_pennies: 1_000)
    cart = described_class.new

    cart.add(item)

    expect(cart.total).to eq(10.00)
  end

  it 'adds items with quantities' do
    item = double(:item, id: 1, price_in_pennies: 1)
    cart = described_class.new

    cart.add(item, quantity: 3)

    expect(cart.quantity(item)).to eq(3)
    expect(cart.total).to eq(0.03)
  end

  it 'increments quantities of items' do
    item = double(:item, id: 1, price_in_pennies: 1)
    cart = described_class.new

    cart.add(item)
    cart.increment(item)

    expect(cart.quantity(item)).to eq(2)
    expect(cart.total).to eq(0.02)
  end

  it 'decrements quantities of items' do
    item = double(:item, id: 1, price_in_pennies: 1)
    cart = described_class.new

    cart.add(item)
    cart.increment(item)
    cart.decrement(item)

    expect(cart.quantity(item)).to eq(1)
    expect(cart.total).to eq(0.01)
  end

  it 'removes items' do
    item = double(:item, id: 1, price_in_pennies: 1_000)
    cart = described_class.new

    cart.add(item)
    cart.remove(item)

    expect(cart.total).to eq(0.0)
  end
end
