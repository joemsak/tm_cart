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

    def set_discount(amount)
      @discount = amount
    end

    def clear_discount
      @discount = 0
    end

    def update_quantity(amount)
      @quantity += amount
    end
  end
end
