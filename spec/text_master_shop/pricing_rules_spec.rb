require "spec_helper"

RSpec.describe TextMasterShop::PricingRules do
  context "Buy one get one Fruit tea" do
    it "will set discount information on every other fruit tea" do
      fruit_tea = { id: 'FR1', unit_price: 3.11, quantity: 3, }
      apple = { id: 'AP1', unit_price: 5.00, quantity: 2, }
      cart = double(:cart, items: [fruit_tea, apple,],)

      rules = described_class.new
      items_with_discounts = rules.apply(cart)

      expect(items_with_discounts).to eq([
        {
          id: 'FR1',
          unit_price: 3.11,
          quantity: 3,
          discount_applied: 'bogoFruitTea',
          discount: 3.11,
        },
        apple,
      ])
    end
  end

  context "Buy apples in bulk" do
    it "will set discount information on every apple for 3 or more" do
      fruit_tea = { id: 'FR1', unit_price: 3.11, quantity: 1, }
      apple = { id: 'AP1', unit_price: 5.00, quantity: 3, }
      cart = double(:cart, items: [fruit_tea, apple,],)

      rules = described_class.new
      items_with_discounts = rules.apply(cart)

      expect(items_with_discounts).to eq([
        fruit_tea,
        {
          id: 'AP1',
          unit_price: 5.00,
          quantity: 3,
          discount_applied: 'bulkApple',
          discount: 1.5,
        },
      ])
    end
  end
end
