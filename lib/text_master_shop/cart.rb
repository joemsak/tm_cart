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
      prices = items.collect { |i| i[:unit_price] * i[:quantity] }
      prices.inject(:+) || 0.0
    end

    def total
      ((subtotal - discounts) * 100).round / 100.0
    end

    def add(item, options = {})
      if found = find(type: item.class.name, id: item.id)
        update_existing(found, options)
      else
        add_new(item, options)
      end

      apply_any_discounts
    end

    def remove(item)
      items.delete_if { |i| i[:id] == item.id }
    end

    def increment(item)
      update_quantity(item, 1)
    end

    def decrement(item)
      update_quantity(item, -1)
    end

    def quantity(item)
      found = find(type: item.class.name, id: item.id)
      (found && found[:quantity]) || 0
    end

    private
    def add_new(item, options)
      qty = options[:quantity] || 1

      items.push({
        id: item.id,
        type: item.class.name,
        quantity: qty,
        unit_price: item.price_in_pennies / 100.0,
      })
    end

    def update_quantity(item, amount)
      found = find(type: item.class.name, id: item.id)
      update_existing(found, quantity: amount)
      apply_any_discounts
    end

    def update_existing(item, options)
      qty = options[:quantity] || 1
      i = items.index(item)
      item[:quantity] += qty
      items[i] = item
    end

    def find(type:, id:)
      items.select { |i| i[:type] == type && i[:id] == id }.first
    end

    def discounts
      items.collect { |i| i[:discount] }.compact.inject(:+) || 0
    end

    def apply_any_discounts
      @items = pricing_rules.apply(items)
    end
  end
end
