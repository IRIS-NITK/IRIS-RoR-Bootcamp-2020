require_relative 'item'
require 'minitest/autorun'

class ItemTest < Minitest::Test
  SECONDS_IN_DAY = 60 * 60 * 2400

  TEST_ITEMS = [
    {
      item: Item.new(
        name: 'Learn Rails 5.2',
        price: 1000,
        category_id: 2,
      ),
      discounted?: false,
      current_price: 1000,
    },
    {
      item: Item.new(
        name: 'Washing Machine',
        price: 13000,
        category_id: 1,
        discount_rate: 15,
        discount_deadline: Time.now + 1 * SECONDS_IN_DAY,
        quantity: 5
      ),
      discounted?: true,
      current_price: 11050.0
    },
    {
      item: Item.new(
        name: 'Socks',
        price: 150,
        category_id: 4,
        discount_rate: 10,
        discount_deadline: Time.now - 1 * SECONDS_IN_DAY,
        quantity: 100
      ),
      discounted?: false,
      current_price: 150
    },
    {
      item: Item.new(
        name: 'Chronograph Watch',
        price: 5000,
        category_id: 4,
        discount_deadline: Time.now + 3 * SECONDS_IN_DAY
      ),
      discounted?: true,
      current_price: 5000
    }
  ]

  STOCK_PRICES_BY_CATEGORY = {
    1 => 55250,
    2 => 1000,
    3 => 0,
    4 => 20000,
  }

  def test_item_has_attribute_quantity
    assert_respond_to Item.new, :quantity, 'class Item has no instance method quantity'
    assert_respond_to Item.new, :"quantity=", 'class Item has no instance method quantity='
  end

  def test_item_can_be_discounted
    TEST_ITEMS.each do |item|
      assert_equal item[:discounted?], item[:item].discounted?
    end
  end

  def test_item_has_current_price
    assert_respond_to Item.new, :current_price, 'class Item has no instance method current_price'

    TEST_ITEMS.each do |item|
      assert_equal item[:current_price], item[:item].current_price
    end
  end

  def test_item_has_stock_price_by_category
    assert_equal STOCK_PRICES_BY_CATEGORY, Item.stock_price_by_category(TEST_ITEMS.map { |item| item[:item] })
  end
end
