module TextMasterShop
  class BulkApplePricingRules
    def self.discount_applies?(item)
      item && item.id == product_code && item.quantity >= min_qty
    end

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
