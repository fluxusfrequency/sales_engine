gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/item.rb'

class ItemTest < Minitest::Test

  attr_accessor :item

  def setup
    @item = Item.new(1, "Item Qui Esse", "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", 75107, 1, "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
  end

  def test_it_returns_an_item_object
    assert_equal Item, item.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, item.id
    assert_equal "Item Qui Esse", item.name
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item.description
    assert_equal 75107, item.unit_price
    assert_equal 1, item.merchant_id
    assert_equal "2012-03-27 14:53:59 UTC", item.created_at
    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at

  end

end
