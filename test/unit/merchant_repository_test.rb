gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class MerchantRepositoryTest < Minitest::Test
  attr_accessor :database, :merchant_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @merchant_repository ||= database.merchant_repository
  end

  def test_it_should_exist
    assert !merchant_repository.nil?
  end

  def test_it_should_have_an_attr_called_merchants_that_returns_an_array_of_merchant_objects
    result = merchant_repository.merchants
    assert_equal Array, result.class
    assert_equal SalesEngine::Merchant, result.first.class
  end

  def test_it_has_an_all_method_that_returns_an_array_of_merchant_objects
    result = merchant_repository.all
    assert_equal Array, result.class
    assert_equal SalesEngine::Merchant, result.last.class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    result = merchant_repository.random
    assert_equal SalesEngine::Merchant, result.class
    random_searches = []
    10.times { random_searches << merchant_repository.random }
    random_searches.reject {|s| s == merchant_repository.merchants[0]}
    assert random_searches.length > 2
  end

end