module TextMasterShop
  class Cart
    private
    attr_reader :items

    public
    def initialize
      @items = []
    end

    def subtotal
      prices = items.collect { |i| i[:unit_price] * i[:quantity] }
      prices.inject(:+) || 0.0
    end

    def total
      (subtotal * 100).round / 100.0
    end

    def add(item, options = {})
      if found = find(type: item.class.name, id: item.id)
        update_existing(found, options)
      else
        add_new(item, options)
      end
    end

    def remove(item)
      items.delete_if { |i| i[:id] == item.id }
    end

    def increment(item)
      found = find(type: item.class.name, id: item.id)
      found[:quantity] += 1
    end

    def decrement(item)
      found = find(type: item.class.name, id: item.id)
      found[:quantity] -= 1
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

    def update_existing(item, options)
      qty = options[:quantity] || 1
      i = items.index(item)
      found[:quantity] += qty
      items[i] = item
    end

    def find(type:, id:)
      items.select { |i| i[:type] == type && i[:id] == id }.first
    end
  end
end
