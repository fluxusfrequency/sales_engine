gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class ItemsTest < Minitest::Test

  attr_accessor :database, :item

  def setup
    data = { :id => 13,
             :name => "Item Qui Esse",
             :description => "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
             :unit_price => 75107,
             :merchant_id => 1,
             :created_at => "2012-03-27 14:53:59 UTC",
             :updated_at => "2012-03-27 14:53:59 UTC"
             }
    @database = SalesEngine::Database
    database.startup_fixtures
    @item ||= SalesEngine::Item.new(data)
  end

  def test_it_should_exist
    assert !item.nil?
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::Item, item.class
  end

end