gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/sales_engine.rb'

class MerchantRepositoryTest < Minitest::Test

  attr_accessor :merchant_repository, :database

  def setup
    @database = SalesEngine::Database
    database.setup_stubs
    @merchant_repository = database.merchant_repository
  end

  def test_it_has_an_attr_called_merchants
    assert merchant_repository.merchants
  end

  def test_the_merchants_array_contains_merchant_objects
    assert_equal SalesEngine::Merchant, merchant_repository.merchants[0].class
  end

  def test_the_all_method_returns_loaded_merchants
    assert merchant_repository.all.length > 1
    assert_equal SalesEngine::Merchant, merchant_repository.all[0].class
    assert_equal SalesEngine::Merchant, merchant_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_merchant_from_the_loaded_merchants
    assert_equal SalesEngine::Merchant, merchant_repository.random.class
    random_searches = []
    10.times do
      random_searches << merchant_repository.random
    end
    random_searches.reject {|s| s == merchant_repository.merchants[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_a_merchant_repository_class
    assert_equal SalesEngine::MerchantRepository, merchant_repository.class
  end

  def test_find_by_id_returns_a_merchant_with_the_correct_id
    assert_equal merchant_repository.merchants[0], merchant_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_a_merchant_with_the_correct_id
    assert_equal 2, merchant_repository.find_all_by_id(2).first.id.to_i
  end

  def test_find_by_name_returns_a_merchant_with_the_correct_name
    assert_equal merchant_repository.merchants[0], merchant_repository.find_by_name("Schroeder-Jerde")
  end

  def test_find_all_by_name_returns_a_merchant_with_the_correct_name
    assert_equal "Schroeder-Jerde", merchant_repository.find_all_by_name("Schroeder-Jerde").first.name
  end

  def test_find_by_created_at_returns_a_merchant_with_the_correct_created_at
    assert_equal merchant_repository.merchants[0], merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_all_by_created_at_returns_a_merchant_with_the_correct_created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC").first.created_at
  end

  def test_find_by_updated_at_returns_a_merchant_with_the_correct_updated_at
    assert_equal merchant_repository.merchants[0], merchant_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_all_by_updated_at_returns_a_merchant_with_the_correct_updated_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC").first.updated_at
  end

  def test_the_most_revenue_method_returns_an_array_of_merchants_sorted_by_revenue
    result = merchant_repository.most_revenue(2)
    assert_equal SalesEngine::Merchant, result.first.class
    assert result.first.revenue > result.last.revenue
  end

  def test_the_most_items_x_method_returns_an_array_of_x_merchants
    result = merchant_repository.most_items(1)
    assert Array, result.class
    assert_equal SalesEngine::Merchant, result.first.class
    assert_equal 1, result.length
  end

  def test_the_revenue_date_method_returns_a_big_decimal
    assert_equal BigDecimal, merchant_repository.revenue("2012-03-27 14:53:59 UTC").class
  end

end
