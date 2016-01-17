module TextMasterShop
  class PricingRules
    RULES = {
      bogoFruitTea: {
        product_code: 'FR1',
        discount_percentage: 100,
        for_every: 2,
        min_qty: 2,
      },

      bulkApple: {
        product_code: 'AP1',
        discount_percentage: 10,
        for_every: 1,
        min_qty: 3,
      },
    }

    def apply(items)
      items = apply_discounts(items, :bogoFruitTea)
      items = apply_discounts(items, :bulkApple)
      items
    end

    private
    def apply_discounts(items, key)
      product_code = RULES[key][:product_code]
      min_qty = RULES[key][:min_qty]

      if item = items.select { |item| item[:id] == product_code }.first
        i = items.index(item)

        updated_item = if item[:quantity] >= min_qty
                         apply_discount(item, key)
                       else
                         clear_discount(item)
                       end

        items[i] = updated_item
      end

      items
    end

    def apply_discount(item, key)
      discount_percentage = RULES[key][:discount_percentage]
      for_every = RULES[key][:for_every]

      qty_to_apply = item[:quantity] / for_every
      discounted_price = item[:unit_price] * (discount_percentage / 100.0)
      amount_to_apply = qty_to_apply * discounted_price

      item[:discount_applied] = key
      item[:discount] = amount_to_apply

      item
    end

    def clear_discount(item)
      item.delete(:discount_applied)
      item.delete(:discount)
      item
    end
  end
end
