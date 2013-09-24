gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/customer.rb'

class CustomerTest < Minitest::Test

  attr_accessor :customer

  def setup
    data = {
      :id => 1
    }

    @customer = Customer.new(data)
  end

  def test_it_loads_a_file
    assert_equal CSV, customer.load("./data/customers.csv").class
  end

end
