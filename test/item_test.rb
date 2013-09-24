gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/item.rb'

class ItemTest < Minitest::Test

  attr_accessor :item

  def setup
    @item = Item.new("Item Qui Esse", "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", 75107, 1, "2012-03-27", "14:53:59 UTC", "2012-03-27 14:53:59 UTC")
  end

  def test
    true
  end

end
