gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/item.rb'

class InvoiceItemTest < Minitest::Test

  attr_accessor :invoice_item

  def setup
    data = {:id => 1,
            :item_id => 539,
            :invoice_id => 1,
            :quantity => 5,
            :unit_price => 13635,
            :created_at => "2012-03-27 14:54:09 UTC",
            :updated_at => "2012-03-27 14:54:09 UTC"
            }
    @invoice_item = SalesEngine::InvoiceItem.new(data, SalesEngine)
  end

  def test_it_sets_up_attrs
    assert_equal 1, invoice_item.id
    assert_equal 539, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 5, invoice_item.quantity
    assert_equal 13635, invoice_item.unit_price
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.created_at
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.updated_at
  end

  def test_it_returns_as_item_object
    assert_equal SalesEngine::InvoiceItem, invoice_item.class
  end

  def test_it_has_an_invoice_method
    assert invoice_item.invoice
  end

  def test_the_invoice_method_returns_an_associated_invoice
    assert_equal SalesEngine::Invoice, invoice_item.invoice.class
  end

  def test_the_invoice_method_returns_an_invoice_with_the_invoice_item_id
    assert_equal invoice_item.invoice_id, invoice_item.invoice.id.to_i
  end

  def test_it_has_an_item_method
    assert invoice_item.item
  end

  def test_the_item_method_returns_an_associated_item
    assert_equal SalesEngine::Item, invoice_item.item.class
  end

  def test_the_item_method_returns_an_item_with_the_invoice_item_id
    found_item = invoice_item.item
    assert_equal invoice_item.item_id, found_item.id.to_i
  end

end
