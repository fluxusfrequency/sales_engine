gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'

class CustomerRepositoryTest < Minitest::Test

  attr_accessor :customer_repository, :database

  def setup
    @database = SalesEngine::Database
    database.setup_stubs
    @customer_repository = database.customer_repository
  end

  def test_it_has_an_attr_called_customer
    assert customer_repository.customers
  end

  def test_the_customers_array_contains_Customer_objects
    assert_equal SalesEngine::Customer, customer_repository.customers[0].class
  end

  def test_the_all_method_returns_loaded_customers
    assert customer_repository.all.length > 1
    assert_equal SalesEngine::Customer, customer_repository.all[0].class
    assert_equal SalesEngine::Customer, customer_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal SalesEngine::Customer, customer_repository.random.class
    random_searches = []
    10.times do
      random_searches << customer_repository.random
    end
    random_searches.reject {|s| s == customer_repository.customers[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_a_customer_repository_class
    assert_equal SalesEngine::CustomerRepository, customer_repository.class
  end

  def test_find_by_id_returns_a_customer_with_the_correct_id
    assert_equal customer_repository.customers[0], customer_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_a_customer_with_the_correct_id
    assert_equal 1, customer_repository.find_all_by_id(1).first.id.to_i
  end

  def test_find_by_first_name_returns_a_customer_with_the_first_name
    assert_equal customer_repository.customers[0], customer_repository.find_by_first_name("Joey")
  end

  ######### LOOK AT THE TEST BELOW AND MAKE OTHERS WORK LIKE IT
  def test_find_all_by_first_name_returns_a_customer_with_the_first_name
    assert_equal "Joey", customer_repository.find_all_by_first_name("Joey").first.first_name
  end

  def test_find_by_last_name_returns_a_customer_with_the_correct_last_name
    assert_equal customer_repository.customers[0], customer_repository.find_by_last_name("Ondricka")
  end

  def test_find_all_by_last_name_returns_a_customer_with_the_correct_last_name
    assert_equal "Ondricka", customer_repository.find_all_by_last_name("Ondricka").first.last_name
  end

  def test_find_by_created_at_returns_a_customer_with_the_correct_created_at
    assert_equal customer_repository.customers[0], customer_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
  end

  def test_find_all_by_created_at_returns_a_customer_with_the_correct_created_at
    assert_equal "2012-03-27 14:54:09 UTC", customer_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC").first.created_at
  end

  def test_find_by_updated_at_returns_a_customer_with_the_correct_updated_at
    assert_equal customer_repository.customers[0], customer_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
  end

  def test_find_all_by_updated_at_returns_a_customer_with_the_correct_updated_at
    assert_equal "2012-03-27 14:54:09 UTC", customer_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC").first.updated_at
  end

end
