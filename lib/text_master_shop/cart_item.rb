module TextMasterShop
  class CartItem
    attr_reader :id, :type, :unit_price, :quantity, :discount_name

    def initialize(product, options = {})
      @id = product.id
      @type = product.class.name
      @unit_price = product.price_in_pennies / 100.0
      @quantity = options.fetch(:quantity, 1)
    end

    def discount
      @discount ||= 0
    end

    def clear_discount
      @discount = 0
    end

    def update_quantity(amount)
      @quantity += amount
    end

    def apply_discount(rules)
      if rules.discount_applies?(self)
        set_discount(rules)
      else
        clear_discount
      end
    end

    private
    def set_discount(rules)
      qty_to_apply = quantity / rules.for_every
      discounted_price = unit_price * (rules.discount_percentage / 100.0)

      @discount = qty_to_apply * discounted_price
    end
  end
end
