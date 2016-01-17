require "spec_helper"

RSpec.describe "Using the checkout system" do
  it "adds an item to the cart" do
    fruit_tea = TextMasterShop::Product.new(id: "FR1",
                                            name: "Fruit tea",
                                            price_in_pennies: 311)
    cart = TextMasterShop::Cart.new

    cart.add(fruit_tea)

    expect(cart.total).to eq(3.11)
  end

  it "updates quantities in the cart" do
    fruit_tea = TextMasterShop::Product.new(id: "FR1",
                                            name: "Fruit tea",
                                            price_in_pennies: 311)
    cart = TextMasterShop::Cart.new

    cart.add(fruit_tea)
    cart.increment(fruit_tea)

    expect(cart.quantity(fruit_tea)).to eq(2)
    expect(cart.total).to eq(6.22)

    cart.decrement(fruit_tea)

    expect(cart.quantity(fruit_tea)).to eq(1)
    expect(cart.total).to eq(3.11)
  end

  it "removes items from the cart" do
    fruit_tea = TextMasterShop::Product.new(id: "FR1",
                                            name: "Fruit tea",
                                            price_in_pennies: 311)
    cart = TextMasterShop::Cart.new

    cart.add(fruit_tea)
    cart.remove(fruit_tea)

    expect(cart.quantity(fruit_tea)).to eq(0)
    expect(cart.total).to eq(0.0)
  end

  it "applies pricing rules" do
    fruit_tea = TextMasterShop::Product.new(id: "FR1",
                                            name: "Fruit tea",
                                            price_in_pennies: 311)
    cart = TextMasterShop::Cart.new

    cart.add(fruit_tea, quantity: 5)

    expect(cart.quantity(fruit_tea)).to eq(5)
    expect(cart.total).to eq(9.33)
  end
end
