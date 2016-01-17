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
    apple = TextMasterShop::Product.new(id: "AP1",
                                        name: "Apple",
                                        price_in_pennies: 500)
    cart = TextMasterShop::Cart.new

    cart.add(apple)
    cart.increment(apple)

    expect(cart.quantity(apple)).to eq(2)
    expect(cart.total).to eq(10.00)

    cart.decrement(apple)

    expect(cart.quantity(apple)).to eq(1)
    expect(cart.total).to eq(5.00)
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

  it "applies pricing rules when incrementing" do
    fruit_tea = TextMasterShop::Product.new(id: "FR1",
                                            name: "Fruit tea",
                                            price_in_pennies: 311)
    cart = TextMasterShop::Cart.new

    cart.add(fruit_tea)
    cart.increment(fruit_tea)

    expect(cart.quantity(fruit_tea)).to eq(2)
    expect(cart.total).to eq(3.11)
  end

  it "disapplies pricing rules when decrementing" do
    fruit_tea = TextMasterShop::Product.new(id: "FR1",
                                            name: "Fruit tea",
                                            price_in_pennies: 311)
    cart = TextMasterShop::Cart.new

    cart.add(fruit_tea)
    cart.increment(fruit_tea)
    cart.decrement(fruit_tea)

    expect(cart.quantity(fruit_tea)).to eq(1)
    expect(cart.total).to eq(3.11)
  end

  it "disapplies pricing rules when removing" do
    fruit_tea = TextMasterShop::Product.new(id: "FR1",
                                            name: "Fruit tea",
                                            price_in_pennies: 311)

    apple = TextMasterShop::Product.new(id: "AP1",
                                        name: "Apple",
                                        price_in_pennies: 500)
    cart = TextMasterShop::Cart.new

    cart.add(fruit_tea, quantity: 2)
    cart.add(apple)
    cart.remove(fruit_tea)

    expect(cart.quantity(fruit_tea)).to eq(0)
    expect(cart.quantity(apple)).to eq(1)
    expect(cart.total).to eq(5.00)
  end
end
