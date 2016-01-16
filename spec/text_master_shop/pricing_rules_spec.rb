require 'spec_helper'

RSpec.describe TextMasterShop::PricingRules do
  it 'reads bogo rules' do
    rules_script = double(:file, readlines: [
      "rule \"bogo\" set unit price 0 for every 2 if id is 'FR1'\n"
    ])

    rules = described_class.new(rules_script)

    bogo = rules['bogo']
    expect(bogo['unit_price']).to eq(0)
    expect(bogo['every']).to eq(2)
    expect(bogo['conditions']).to eq("id == 'FR1'")
  end

  it 'reads bulk purchase rules' do
    rules_script = double(:file, readlines: [
      "rule \"bulk\" unit price 4.55 if id is 'AP1' and quantity is at least 3\n"
    ])

    rules = described_class.new(rules_script)

    bulk = rules['bulk']
    expect(bulk['unit_price']).to eq(4.55)
    expect(bulk['every']).to eq(1)
    expect(bulk['conditions']).to eq("id == 'AP1' && quantity >= 3")
  end
end
