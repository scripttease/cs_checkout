class Checkout

  ITEMS = [
    { product_code: 'FR1', name: 'Fruit tea', price: 3.11, offer: 'bogof', offer_applied: false },
    { product_code: 'SR1', name: 'Strawberries', price: 5.00,  offer: 'three_or_more', offer_applied: false },
    { product_code: 'CF1', name: 'Coffee', price: 11.23, offer: 'none', offer_applied: false }
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

  def check_for_and_apply_bogof_offer
    bogof_product = @basket.find { |item|
      item[:offer] == 'bogof' && item[:offer_applied] == false
    }
    return self if bogof_product.nil?

    count_two_or_more_products = @basket.select { |item|
      item[:offer] == 'bogof' && item[:offer_applied] == false
    }
    return self if count_two_or_more_products.count < 2

    bogof_product_code = bogof_product[:product_code]

    @basket
      .select { |item| item[:product_code] == bogof_product_code }
      .reject { |item| item[:offer_applied] }
      .each.with_index { |item, index|
        item[:price] = 0 if index.odd? && index > 0
        item[:offer_applied] = true
      }

    check_for_and_apply_bogof_offer
      
    self
  end
  
  def check_for_and_apply_three_or_more_offer

    count_three_or_more_products = @basket.select { |item|
      item[:offer] == 'three_or_more' && item[:offer_applied] == false
    }

    return self if count_three_or_more_products.nil? || count_three_or_more_products.count < 3

    three_or_more_product_code = count_three_or_more_products.first[:product_code]

    @basket
      .select { |item| item[:product_code] == three_or_more_product_code }
      .reject { |item| item[:offer_applied] }
      .each.with_index { |item, index|
        item[:price] = item[:price] * 0.9
        item[:offer_applied] = true
      }

    check_for_and_apply_three_or_more_offer

    self
  end


  def total
    check_for_and_apply_bogof_offer
    check_for_and_apply_three_or_more_offer
    
    total = @basket.map { |item| item[:price] }.sum || 0
  end

end
