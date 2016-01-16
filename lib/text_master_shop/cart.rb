module TextMasterShop
  class Cart
    private
    attr_reader :items

    public
    def initialize
      @items = []
    end

    def find(type:, id:)
      items.select { |i| i[:id] == id }.first
    end

    def add(item, options = {})
      items.push({
        id: item.id,
        quantity: options[:quantity] || 1,
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
  end
end
