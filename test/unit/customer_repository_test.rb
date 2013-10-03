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

end