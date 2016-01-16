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
      (((subtotal * sales_tax) + shipping + discounts) * 100).round / 100.0
    end

    def add(item, options = {})
      items.push({
        id: item.id,
        type: item.class.name,
        quantity: options[:quantity] || 1,
        unit_price: item.price_in_pennies / 100.0,
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
      (found && found[:quantity]) || 0
    end

    private
    def find(type:, id:)
      items.select { |i| i[:type] == type && i[:id] == id }.first
    end

    def sales_tax
      1.0 # This will be important in later sprints
    end

    def shipping
      0.0 # This will be important in later sprints
    end

    def discounts
      # discounts only work for TextMasterShop::Product in this sprint
      discount = 0

      pricing_rules.parsed.each do |_, rule|
        rule["conditions"].each do |cond|
          attr = cond["attr"].to_sym
          op = cond["operator"]
          value = cond["expected_value"]

          selected = items.select { |item|
            item[:type] == "TextMasterShop::Product" &&
              item[attr].send(op, value)
          }.first

          qty_to_apply = selected[:quantity] / rule["every"]
          discount += (selected[:unit_price] * qty_to_apply)
        end
      end

      -discount
    end
  end
end
