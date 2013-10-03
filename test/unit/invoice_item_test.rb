gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class InvoiceItemsTest < Minitest::Test

  attr_accessor :database, :invoice_item

  def setup
    data = { :id => 1,
             :item_id => 539,
             :invoice_id => 1,
             :quantity => 5,
             :unit_price => 13635,
             :created_at => "2012-03-27 14:54:09 UTC",
             :updated_at => "2012-03-27 14:54:09 UTC"
             }

    @database = SalesEngine::Database
    database.startup_fixtures
    @invoice_item ||= SalesEngine::InvoiceItem.new(data)
  end

  def test_it_should_exist
    assert !invoice_item.nil?
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::InvoiceItem, invoice_item.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, invoice_item.id
    assert_equal 539, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 5, invoice_item.quantity
    assert_equal 13635, invoice_item.unit_price
    assert_equal Date.parse("2012-03-27 14:54:09 UTC"), invoice_item.created_at
    assert_equal Date.parse("2012-03-27 14:54:09 UTC"), invoice_item.updated_at
  end

end