module TextMasterShop
  class BulkApplePricingRules < PricingRules
    def self.product_code
      'AP1'
    end

    def self.min_qty
      3
    end

    def self.discount_percentage
      10
    end

    def self.for_every
      1
    end
  end
end
