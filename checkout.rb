class Checkout
  ITEMS = [
    { product_code: 'FR1', name: 'Fruit tea', price: 3.11 },
    { product_code: 'SR1', name: 'Strawberries', price: 5.00 },
    { product_code: 'CF1', name: 'Coffee', price: 11.23},
  ]

  attr_reader :basket

  def initialize(basket = [])
    @basket = basket
  end

  def scan(item_product_code = '')
    item = ITEMS.find { |i| i[:product_code] == item_product_code }
    
    @basket << item unless item.nil?
    self
  end

  def total
    @basket.map { |i| i[:price] }.sum
  end
end
