gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class InvoiceTest < Minitest::Test

  attr_accessor :database, :invoice

  def setup
    data = { :id => 1,
             :customer_id => 1,
             :merchant_id => 3,
             :status => "shipped",
             :created_at => "2012-03-25 09:54:09 UTC",
             :updated_at => "2012-03-25 09:54:09 UTC"
             }

    @database = SalesEngine::Database
    database.startup_fixtures
    @invoice ||= SalesEngine::Invoice.new(data)
  end

  def test_it_should_exist
    assert !invoice.nil?
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::Invoice, invoice.class
  end

  def test_it_sets_up_attrs
      assert_equal 1, invoice.id
      assert_equal 1, invoice.customer_id
      assert_equal 3, invoice.merchant_id
      assert_equal "shipped", invoice.status
      assert_equal Date.parse("2012-03-25 09:54:09 UTC"), invoice.created_at
      assert_equal Date.parse("2012-03-25 09:54:09 UTC"), invoice.updated_at
    end

end