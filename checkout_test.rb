require 'minitest/autorun'
require_relative 'checkout'


class CheckoutTest < Minitest::Test

  def test_scan_item
    assert_equal [{ product_code: 'FR1', name: 'Fruit tea', price: 3.11, }] , Checkout.new.scan('FR1').basket
  end

  def test_scan_one_item_checkout_total
    assert_equal 3.11, Checkout.new.scan('FR1').total
  end
end
