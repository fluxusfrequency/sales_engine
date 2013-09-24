gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/customer.rb'
require_relative '../lib/sales_engine/customer_repository.rb'

class CustomerRepositoryTest < Minitest::Test

  attr_accessor :customer_repository

  def setup
    @customer_repository = CustomerRepository.new('test/fixtures/customer_repository_fixture.csv')
  end

  def test_it_has_an_attr_called_customer
    assert customer_repository.customers
  end

  def test_populates_a_list_of_customer
    assert customer_repository.populate_list
  end

  def test_the_items_array_contains_Customer_objects
    assert_equal Customer, customer_repository.customers[0].class
  end

  def test_the_all_method_returns_loaded_customers
    assert customer_repository.all.length > 1
    assert_equal Customer, customer_repository.all[0].class
    assert_equal Customer, customer_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal Customer, customer_repository.random.class
    random_searches = []
    10.times do
      random_searches << customer_repository.random
    end
    random_searches.reject {|s| s == customer_repository.customers[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_a_customer_repository_class
    assert_equal CustomerRepository, customer_repository.class
  end

end
