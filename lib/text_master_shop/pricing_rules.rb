module TextMasterShop
  class PricingRules
    @@discounters = []

    def self.inherited(base)
      @@discounters << base
    end

    def apply(items)
      @@discounters.each do |discounter|
        apply_discounts(items, discounter)
      end

      items
    end

    def self.discount_applies?(item)
      item && item.id == product_code && item.quantity >= min_qty
    end

    private
    def apply_discounts(items, rules)
      if item = items.select { |item| item.id == rules.product_code }.first
        item.apply_discount(rules)
      end
    end
  end
end
