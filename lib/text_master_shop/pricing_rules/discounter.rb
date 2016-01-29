module TextMasterShop
  module Discounter
    def discount_applies?(item)
      item && item.id == product_code && item.quantity >= min_qty
    end
  end
end
