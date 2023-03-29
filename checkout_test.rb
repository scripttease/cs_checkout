require 'minitest/autorun'
require_relative 'checkout'


class CheckoutTest < Minitest::Test

  def test_scan_item
    assert_equal [{ product_code: 'FR1', name: 'Fruit tea', price: 3.11, offer: 'bogof', offer_applied: false},] , Checkout.new.scan('FR1').basket
  end

  def test_scan_incorrect_product_code
    assert_equal [], Checkout.new.scan('AB1').basket
  end

  def test_scan_no_product_code
    assert_equal [], Checkout.new.scan('').basket
  end

  def test_scan_invalid_type_product_code
    assert_equal [], Checkout.new.scan(1).basket
  end

  def test_scan_one_item_checkout_total
    assert_equal 3.11, Checkout.new.scan('FR1').total
  end

  def test_scan_two_items_checkout_total
    assert_equal 8.11, Checkout.new.scan('FR1').scan('SR1').total
  end

  def test_bogof_offer_applied_to_two_items
    assert_equal 3.11, Checkout.new([
      { product_code: 'FR1', name: 'Fruit tea', price: 3.11, offer: 'bogof', offer_applied: false },
      { product_code: 'FR1', name: 'Fruit tea', price: 3.11, offer: 'bogof', offer_applied: false },
    ]).total
  end

  def test_bogof_offer_applied_to_three_items
    assert_equal 6.22, Checkout.new([
      { product_code: 'FR1', name: 'Fruit tea', price: 3.11, offer: 'bogof', offer_applied: false },
      { product_code: 'FR1', name: 'Fruit tea', price: 3.11, offer: 'bogof', offer_applied: false },
      { product_code: 'FR1', name: 'Fruit tea', price: 3.11, offer: 'bogof', offer_applied: false },
    ]).total
  end

  def test_bogof_when_offer_on_two_kinds_of_item
  end

  def test_three_items_with_three_or_more_offer
    assert_equal 13.50, Checkout.new([
      { product_code: 'SR1', name: 'Strawberries', price: 5.00,  offer: 'three_or_more', offer_applied: false },
      { product_code: 'SR1', name: 'Strawberries', price: 5.00,  offer: 'three_or_more', offer_applied: false },
      { product_code: 'SR1', name: 'Strawberries', price: 5.00,  offer: 'three_or_more', offer_applied: false },
    ]).total
  end

  def test_two_items_with_three_or_more_offer
    assert_equal 10.00, Checkout.new([
      { product_code: 'SR1', name: 'Strawberries', price: 5.00,  offer: 'three_or_more', offer_applied: false },
      { product_code: 'SR1', name: 'Strawberries', price: 5.00,  offer: 'three_or_more', offer_applied: false },
    ]).total
  end
end
