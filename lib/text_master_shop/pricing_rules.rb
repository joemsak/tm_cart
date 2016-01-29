require "text_master_shop/pricing_rules/bogo_fruit_tea_pricing_rules"
require "text_master_shop/pricing_rules/bulk_apple_pricing_rules"

module TextMasterShop
  class PricingRules
    def apply(items)
      items = apply_discounts(items, BogoFruitTeaPricingRules)
      items = apply_discounts(items, BulkApplePricingRules)
      items
    end

    private
    def apply_discounts(items, rules)
      product_code = rules.product_code
      min_qty = rules.min_qty

      if item = items.select { |item| item.id == product_code }.first
        if item.quantity >= min_qty
          i = items.index(item)
          apply_discount(item, rules)
          items[i] = item
        else
          item.clear_discount
        end
      end

      items
    end

    def apply_discount(item, rules)
      discount_percentage = rules.discount_percentage
      for_every = rules.for_every

      qty_to_apply = item.quantity / for_every
      discounted_price = item.unit_price * (discount_percentage / 100.0)
      amount_to_apply = qty_to_apply * discounted_price

      item.set_discount(amount_to_apply)

      item
    end
  end
end
