gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/invoice.rb'

class InvoiceTest < Minitest::Test

  attr_accessor :invoice

  def setup
    data = {:id => 1,
            :customer_id => 1,
            :merchant_id => 26,
            :status => "shipped",
            :created_at => "2012-03-25 09:54:09 UTC",
            :updated_at => "2012-03-25 09:54:09 UTC"
            }
   @invoice = Invoice.new(data)
  end

  def test_it_returns_an_item_object
    assert_equal Invoice, invoice.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
    assert_equal "shipped", invoice.status
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end

  def test_it_has_a_transactions_method
    assert true, invoice.transactions
  end

  def test_it_has_an_invoice_items_method
    assert true, invoice.invoice_items
  end

  def test_it_has_an_items_method
    assert true, invoice.items
  end

  def test_it_has_a_customer_method
    assert true, invoice.customer
  end

  def test_it_has_a_merchant_method
    assert true, invoice.merchant
  end

end

