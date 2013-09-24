gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/customer.rb'

class CustomerTest < Minitest::Test

  attr_accessor :customer

  def setup
    data = {:id => 1,
            :first_name => "Joey"
            :last_name => "Ondricka"
            :created_at => "2012-03-27 14:54:09 UTC"
            :updated_at => "2012-03-27 14:54:09 UTC"
          }

    @customer = Customer.new(data)
  end

  def test_it_returns_an_item_object
    assert_equal Customer, customer.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, customer.id
    assert_equal "Joey", customer.first_name
    assert_equal "Ondricka", customer.last_name
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
  end

  def test_it_has_an_invoice
    assert true, customer.invoice
  end

end
