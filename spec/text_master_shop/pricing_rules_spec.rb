require "spec_helper"

RSpec.describe TextMasterShop::PricingRules do
  context "Buy one get one Fruit tea" do
    it "will set discount information on every other fruit tea" do
      fruit_tea = double(TextMasterShop::CartItem, id: 'FR1',
                                                   unit_price: 3.11,
                                                   quantity: 3,)
      apple = double(TextMasterShop::CartItem, id: 'AP1',
                                               unit_price: 5.00,
                                               quantity: 2,)

      rules = described_class.new

      expect(apple).to receive(:clear_discount)
      expect(fruit_tea).to receive(:set_discount).with(3.11)

      rules.apply([fruit_tea, apple,])
    end
  end

  context "Buy apples in bulk" do
    it "will set discount information on every apple for 3 or more" do
      fruit_tea = double(TextMasterShop::CartItem, id: 'FR1',
                                                   unit_price: 3.11,
                                                   quantity: 1,)
      apple = double(TextMasterShop::CartItem, id: 'AP1',
                                               unit_price: 5.00,
                                               quantity: 3,)

      rules = described_class.new

      expect(fruit_tea).to receive(:clear_discount)
      expect(apple).to receive(:set_discount).with(1.5)

      rules.apply([fruit_tea, apple,])
    end
  end
end
