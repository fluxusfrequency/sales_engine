gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/customer.rb'

class CustomerTest < Minitest::Test

  attr_accessor :customer

  def setup
    @customer = Customer.new(1,2,3,4,5)
  end

  # def test_initializes_from_a_hash_of_data
  #   customer.
  #

  def test_it_loads_a_file
    assert_equal CSV, customer.load("./data/customers.csv").class
  end

end
