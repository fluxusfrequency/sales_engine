gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class ItemRepositoryTest < Minitest::Test
  attr_accessor :database, :item_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @item_repository ||= database.item_repository
  end

  def test_it_should_exist
    assert !item_repository.nil?
  end

  def test_it_should_have_an_attr_called_items_that_returns_an_array_of_item_objects
    result = item_repository.items
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.first.class
  end

end