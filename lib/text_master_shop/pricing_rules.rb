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

      if item = items.select { |item| item.id == product_code }.first
        if item.quantity >= min_qty
          i = items.index(item)
          apply_discount(item, key)
          items[i] = item
        else
          item.clear_discount
        end
      end

      items
    end

    def apply_discount(item, key)
      discount_percentage = RULES[key][:discount_percentage]
      for_every = RULES[key][:for_every]

      qty_to_apply = item.quantity / for_every
      discounted_price = item.unit_price * (discount_percentage / 100.0)
      amount_to_apply = qty_to_apply * discounted_price

      item.set_discount(key, amount_to_apply)

      item
    end
  end
end
