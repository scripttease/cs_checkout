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
end
