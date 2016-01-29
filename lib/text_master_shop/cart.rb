module TextMasterShop
  class Cart
    private
    attr_reader :items, :pricing_rules

    public
    def initialize(pricing_rules = PricingRules.new)
      @items = []
      @pricing_rules = pricing_rules
    end

    def subtotal
      prices = items.collect { |i| i.unit_price * i.quantity }
      prices.inject(:+) || 0.0
    end

    def total
      ((subtotal - discounts) * 100).round / 100.0
    end

    def add(item, options = {})
      if found = find(item)
        update_existing(found, options)
      else
        add_new(item, options)
      end
    end

    def remove(item)
      items.delete_if { |i| i.id == item.id }
    end

    def increment(item)
      update_quantity(item, 1)
    end

    def decrement(item)
      update_quantity(item, -1)
    end

    def quantity(item)
      found = find(item)
      (found && found.quantity) || 0
    end

    private
    def add_new(item, options)
      cart_item = CartItem.new(item, options)

      items.push(cart_item)
      apply_any_discounts
    end

    def update_quantity(item, amount)
      found = find(item)
      update_existing(found, quantity: amount)
    end

    def update_existing(item, options)
      qty = options[:quantity] || 1
      item.update_quantity(qty)

      i = items.index(item)
      items[i] = item

      apply_any_discounts
    end

    def find(item)
      items.select { |i| i.type == item.class.name && i.id == item.id }.first
    end

    def discounts
      items.collect { |i| i.discount }.compact.inject(:+) || 0
    end

    def apply_any_discounts
      @items = pricing_rules.apply(items)
    end
  end
end
