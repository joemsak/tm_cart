module TextMasterShop
  class Cart
    private
    attr_reader :items

    public
    def initialize
      @items = []
    end

    def total
      prices = items.collect { |i| i[:unit_price] * i[:quantity] }
      sum_in_pennies = prices.inject(:+) || 0
      sum_in_pennies / 100.0
    end

    def add(item, options = {})
      items.push({
        id: item.id,
        type: item.class.name,
        quantity: options[:quantity] || 1,
        unit_price: item.price_in_pennies,
      })
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
      found[:quantity]
    end

    private
    def find(type:, id:)
      items.select { |i| i[:type] == type && i[:id] == id }.first
    end
  end
end
