module TextMasterShop
  class BogoFruitTeaPricingRules
    def self.discount_applies?(item)
      item && item.id == product_code && item.quantity >= min_qty
    end

    def self.product_code
      'FR1'
    end

    def self.min_qty
      2
    end

    def self.discount_percentage
      100
    end

    def self.for_every
      2
    end
  end
end
