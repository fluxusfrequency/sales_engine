gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class CustomerRepositoryTest < Minitest::Test
  attr_accessor :database, :customer_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @customer_repository ||= database.customer_repository
  end

  def test_it_should_exist
    assert !customer_repository.nil?
  end

  def test_it_should_have_an_attr_called_customers_that_returns_an_array_of_customer_objects
    result = customer_repository.customers
    assert_equal Array, result.class
    assert_equal SalesEngine::Customer, result.first.class
  end

  def test_it_has_an_all_method_that_returns_an_array_of_customer_objects
    result = customer_repository.all
    assert_equal Array, result.class
    assert_equal SalesEngine::Customer, result.last.class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    result = customer_repository.random
    assert_equal SalesEngine::Customer, result.class
    random_searches = []
    10.times { random_searches << customer_repository.random }
    random_searches.reject {|s| s == customer_repository.customers[0]}
    assert random_searches.length > 2
  end

  def test_it_has_a_find_by_id_method_that_returns_a_customer_with_the_matching_id
    result = customer_repository.find_by_id(5)
    assert_equal SalesEngine::Customer, result.class
    assert_equal 5, result.id.to_i
  end

  def test_it_has_a_find_all_by_id_method_that_returns_an_array_of_customers_with_the_matching_id
    result = customer_repository.find_all_by_id(5)
    assert_equal Array, result.class
    assert_equal SalesEngine::Customer, result.first.class
    assert_equal 5, result.last.id.to_i
  end

  def test_it_has_a_find_by_first_name_method_that_returns_an_customer_with_the_matching_id
    result = customer_repository.find_by_first_name("Dejon")
    assert_equal SalesEngine::Customer, result.class
    assert_equal "Dejon", result.first_name
  end

  def test_it_has_a_find_all_by_first_name_method_that_returns_an_array_of_customers_with_the_matching_id
    result = customer_repository.find_all_by_first_name("Dejon")
    assert_equal Array, result.class
    assert_equal SalesEngine::Customer, result.last.class
    assert_equal "Dejon", result.last.first_name
  end

  def test_it_has_a_find_by_last_name_method_that_returns_an_customer_with_the_matching_id
    result = customer_repository.find_by_last_name("Kuhn")
    assert_equal SalesEngine::Customer, result.class
    assert_equal "Kuhn", result.last_name
  end

  def test_it_has_a_find_all_by_last_name_method_that_returns_an_array_of_customers_with_the_matching_id
    result = customer_repository.find_all_by_last_name("Kuhn")
    assert_equal Array, result.class
    assert_equal SalesEngine::Customer, result.last.class
    assert_equal "Kuhn", result.last.last_name
  end

  def test_it_has_a_find_by_created_at_method_that_returns_an_invoice_item_with_the_matching_id
    result = customer_repository.find_by_created_at(Date.parse("2012-03-27 14:54:10 UTC"))
    assert_equal SalesEngine::Customer, result.class
    assert_equal Date.parse("2012-03-27 14:54:10 UTC"), result.created_at
  end

  def test_it_has_a_find_all_by_created_at_method_that_returns_an_array_of_customers_with_the_matching_id
    result = customer_repository.find_all_by_created_at(Date.parse("2012-03-27 14:54:10 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Customer, result.last.class
    assert_equal Date.parse("2012-03-27 14:54:10 UTC"), result.last.created_at
  end

  def test_it_has_a_find_by_updated_at_method_that_returns_an_invoice_item_with_the_matching_id
    result = customer_repository.find_by_updated_at(Date.parse("2012-03-27 14:54:11 UTC"))
    assert_equal SalesEngine::Customer, result.class
    assert_equal Date.parse("2012-03-27 14:54:11 UTC"), result.updated_at
  end

  def test_it_has_a_find_all_by_updated_at_method_that_returns_an_array_of_customers_with_the_matching_id
    result = customer_repository.find_all_by_updated_at(Date.parse("2012-03-27 14:54:11 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Customer, result.last.class
    assert_equal Date.parse("2012-03-27 14:54:11 UTC"), result.last.updated_at
  end


end