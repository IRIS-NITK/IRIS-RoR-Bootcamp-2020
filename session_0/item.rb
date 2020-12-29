class Item
  CATEGORIES = {
    1 => 'Electronics/Gadgets',
    2 => 'Books',
    3 => 'Furniture',
    4 => 'Miscellaneous'
  }

  # TODO: Store quantity
  attr_accessor :name, :price, :category_id, :discount_rate,
    :discount_deadline

  def initialize(name: '', price: 0, quantity: 1, category_id: 4,
                 discount_rate: 0, discount_deadline: Time.now)
    @name = name
    @price = price
    @category_id = category_id
    @discount_rate = discount_rate
    @discount_deadline = discount_deadline
    @quantity = quantity
  end

  # Returns a boolean value whether than item is discounted i.e. the
  # discount deadline has been crossed or not.
  def discounted?
    raise NotImplementedError # TODO
  end

  # If the item is discounted, the current price is 
  # `price * (100 - discount rate) / 100`. Otherwise, it is same as the price.
  #
  # TODO: Implement instance method 'current_price'

  # The stock price of item is defined as product of current price and
  # quantity.
  # 
  # This function takes an Array of items as the parameter and returns
  # a hash with the category id as the key and sum of stock
  # prices of all items of that category as the value.
  #
  # Note: If there are no items for category, stock price for category
  # should be zero.
  def self.stock_price_by_category(items)
  end
end
