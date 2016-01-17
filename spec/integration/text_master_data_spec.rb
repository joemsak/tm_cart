require "spec_helper"

RSpec.describe "TextMaster's test data" do
  let(:fruit_tea) { TextMasterShop::Product.new(id: 'FR1',
                                                name: 'Fruit tea',
                                                price_in_pennies: 311) }

  let(:apple) { TextMasterShop::Product.new(id: 'AP1',
                                            name: 'Apple',
                                            price_in_pennies: 500) }

  let(:coffee) { TextMasterShop::Product.new(id: 'CF1',
                                             name: 'Coffee',
                                             price_in_pennies: 1_123) }

  let(:cart) { TextMasterShop::Cart.new }

  # Basket: FR1, AP1, FR1, CF1
  # Total price expected: $22.25
  # *** CORRECTED TOTAL PRICE EXPECTED: 19.34 ***
  it "applies buy-one-get-one to complex cart with fruit tea" do
    cart.add(fruit_tea)
    cart.add(apple)
    cart.add(fruit_tea)
    cart.add(coffee)

    expect(cart.total).to eq(19.34)
  end

  # Basket: FR1, FR1
  # Total price expected: $3.11
  it "applies buy-one-get-one to simple cart with fruit tea" do
    cart.add(fruit_tea)
    cart.add(fruit_tea)

    expect(cart.total).to eq(3.11)
  end
  #
  # Basket: AP1, AP1, FR1, AP1
  # Total price expected: $16.61
  it "applies bulk apple to simple cart with apple" do
    cart.add(apple)
    cart.add(apple)
    cart.add(fruit_tea)
    cart.add(apple)

    expect(cart.total).to eq(16.61)
  end
end
