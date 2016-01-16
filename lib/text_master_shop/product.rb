module TextMasterShop
  class Product
    attr_reader :id, :name, :price_in_pennies

    def initialize(id:, name:, price_in_pennies:)
      @id = id
      @name = name
      @price_in_pennies = price_in_pennies
    end
  end
end
