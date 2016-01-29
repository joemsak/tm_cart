require "text_master_shop/pricing_rules/discounter"
require "text_master_shop/pricing_rules/bogo_fruit_tea_pricing_rules"
require "text_master_shop/pricing_rules/bulk_apple_pricing_rules"

module TextMasterShop
  class PricingRules
    def apply(items)
      apply_discounts(items, BogoFruitTeaPricingRules)
      apply_discounts(items, BulkApplePricingRules)
      items
    end

    private
    def apply_discounts(items, rules)
      if item = items.select { |item| item.id == rules.product_code }.first
        item.apply_discount(rules)
      end
    end
  end
end
