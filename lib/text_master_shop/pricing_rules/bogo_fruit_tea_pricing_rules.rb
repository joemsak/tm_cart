module TextMasterShop
  class BogoFruitTeaPricingRules
    extend Discounter

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
