gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/merchant.rb'
require_relative '../lib/sales_engine/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test
  attr_accessor :merchant_repository

  def setup
    @merchant_repository = MerchantRepository.new('test/fixtures/merchant_repository_fixture.csv')
  end

  def test_it_has_an_attr_called_merchants
    assert merchant_repository.merchants
  end

  def test_populates_a_list_of_merchants
    assert merchant_repository.populate_list
  end

  def test_the_merchants_array_contains_merchant_objects
    assert_equal Merchant, merchant_repository.merchants[0].class
  end

  def test_the_all_method_returns_loaded_merchants
    assert merchant_repository.all.length > 1
    assert_equal Merchant, merchant_repository.all[0].class
    assert_equal Merchant, merchant_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_merchant_from_the_loaded_merchants
    assert_equal Merchant, merchant_repository.random.class
    random_searches = []
    10.times do
      random_searches << merchant_repository.random
    end
    random_searches.reject {|s| s == merchant_repository.merchants[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_a_merchant_repository_class
    assert_equal MerchantRepository, merchant_repository.class
  end

  def test_find_by_id_returns_a_merchant_with_the_correct_id
    assert_equal merchant_repository.merchants[0], merchant_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_a_merchant_with_the_correct_id
    assert_equal merchant_repository.merchants.select { |merchant| merchant.id.to_i == 2 }, merchant_repository.find_all_by_id(2)
  end

  def test_find_by_name_returns_a_merchant_with_the_correct_name
    assert_equal merchant_repository.merchants[0], merchant_repository.find_by_name("Schroeder-Jerde")
  end

  def test_find_all_by_name_returns_a_merchant_with_the_correct_name
    assert_equal merchant_repository.merchants.select { |merchant| merchant.name == "Schroeder-Jerde" }, merchant_repository.find_all_by_name("Schroeder-Jerde")
  end

  def test_find_by_created_at_returns_a_merchant_with_the_correct_created_at
    assert_equal merchant_repository.merchants[0], merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_all_by_created_at_returns_a_merchant_with_the_correct_created_at
    assert_equal merchant_repository.merchants.select { |merchant| merchant.created_at == "2012-03-27 14:53:59 UTC"}, merchant_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_by_updated_at_returns_a_merchant_with_the_correct_updated_at
    assert_equal merchant_repository.merchants[0], merchant_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_all_by_updated_at_returns_a_merchant_with_the_correct_updated_at
    assert_equal merchant_repository.merchants.select { |merchant| merchant.updated_at == "2012-03-27 14:53:59 UTC"}, merchant_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
  end
end
