module TextMasterShop
  class PricingRules
    PRODUCT_CODES = {
      fruit_tea: 'FR1',
      apple: 'AP1',
    }

    DISCOUNT_CODES = {
      fruit_tea: 'bogoFruitTea',
      apple: 'bulkApple',
    }

    DISCOUNT_AMOUNTS = {
      fruit_tea: 3.11,
      apple: 0.5,
    }

    DISCOUNT_EVERY = {
      fruit_tea: 2,
      apple: 1,
    }

    DISCOUNT_AFTER = {
      fruit_tea: 1,
      apple: 2,
    }

    def apply(cart)
      items = cart.items
      items = apply_discounts(items, :fruit_tea)
      items = apply_discounts(items, :apple)
      items
    end

    private
    def apply_discounts(items, key)
      if item = items.select { |item| item[:id] == PRODUCT_CODES[key] }.first
        i = items.index(item)

        if item[:quantity] > DISCOUNT_AFTER[key]
          qty_to_apply = item[:quantity] / DISCOUNT_EVERY[key]
          amount_to_apply = qty_to_apply * DISCOUNT_AMOUNTS[key]

          item[:discount_applied] = DISCOUNT_CODES[key]
          item[:discount] = amount_to_apply

          items[i] = item
        end
      end

      items
    end
  end
end
