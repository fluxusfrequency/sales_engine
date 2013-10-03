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

  def test_the_random_method_returns_a_random_merchant_from_the_loaded_merchants
    result = merchant_repository.random
    assert_equal SalesEngine::Merchant, result.class
    random_searches = []
    10.times { random_searches << merchant_repository.random }
    random_searches.reject {|s| s == merchant_repository.merchants[0]}
    assert random_searches.length > 2
  end

  def test_it_has_a_find_by_id_method_that_returns_a_merchant_with_the_matching_id
    result = merchant_repository.find_by_id(8)
    assert_equal SalesEngine::Merchant, result.class
    assert_equal 8, result.id.to_i
  end

  def test_it_has_a_find_all_by_id_method_that_returns_an_array_of_merchants_with_the_matching_id
    result = merchant_repository.find_all_by_id(8)
    assert_equal Array, result.class
    assert_equal SalesEngine::Merchant, result.first.class
    assert_equal 8, result.last.id.to_i
  end

  def test_it_has_a_find_by_name_method_that_returns_a_merchant_with_the_matching_name
    result = merchant_repository.find_by_name("Williamson Group")
    assert_equal SalesEngine::Merchant, result.class
    assert_equal "Williamson Group", result.name
  end

  def test_it_has_a_find_all_by_name_method_that_returns_an_array_of_merchants_with_the_matching_name
    result = merchant_repository.find_all_by_name("Williamson Group")
    assert_equal Array, result.class
    assert_equal SalesEngine::Merchant, result.last.class
    assert_equal "Williamson Group", result.last.name
  end

  def test_it_has_a_find_by_created_at_method_that_returns_a_merchant_itm_with_the_matching_id
    result = merchant_repository.find_by_created_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal SalesEngine::Merchant, result.class
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), result.created_at
  end

  def test_it_has_a_find_all_by_created_at_method_that_returns_an_array_of_merchants_with_the_matching_id
    result = merchant_repository.find_all_by_created_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Merchant, result.last.class
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), result.last.created_at
  end

  def test_it_has_a_find_by_updated_at_method_that_returns_a_merchant_itm_with_the_matching_id
    result = merchant_repository.find_by_updated_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal SalesEngine::Merchant, result.class
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), result.updated_at
  end

  def test_it_has_a_find_all_by_updated_at_method_that_returns_an_array_of_merchants_with_the_matching_id
    result = merchant_repository.find_all_by_updated_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Merchant, result.last.class
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), result.last.updated_at
  end

end