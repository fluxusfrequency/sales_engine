gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/invoice.rb'

class InvoiceTest < Minitest::Test

  attr_accessor :invoice, :database

  def setup
    data = {:id => 1,
            :customer_id => 1,
            :merchant_id => 3,
            :status => "shipped",
            :created_at => "2012-03-25 09:54:09 UTC",
            :updated_at => "2012-03-25 09:54:09 UTC"
            }
    @invoice = SalesEngine::Invoice.new(data, SalesEngine)
    @database = SalesEngine::Database
    database.setup_stubs
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::Invoice, invoice.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 3, invoice.merchant_id
    assert_equal "shipped", invoice.status
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end

  def test_it_has_a_transactions_method
    assert invoice.transactions
  end

  def test_the_transcations_method_returns_assocaiated_transcations
    assert_equal SalesEngine::Transaction, invoice.transactions[0].class
  end

  def test_the_transcations_method_returns_transcations_with_the_invoice_id
    assert_equal invoice.id, invoice.transactions[0].invoice_id.to_i
    assert_equal invoice.id, invoice.transactions[-1].invoice_id.to_i
  end

  def test_it_has_an_invoice_items_method
    assert invoice.invoice_items
  end

  def test_the_invoice_items_method_returns_assocaiated_invoice_items
    assert_equal SalesEngine::InvoiceItem, invoice.invoice_items[0].class
  end

  def test_the_invoice_items_method_returns_invoice_items_with_the_invoice_id
    assert_equal invoice.id, invoice.invoice_items[0].invoice_id.to_i
    assert_equal invoice.id, invoice.invoice_items[-1].invoice_id.to_i
  end

  def test_it_has_an_items_method
    assert invoice.items
  end

  # def test_the_items_method_returns_assocaiated_items
  #   assert_equal Item, invoice.items[0].class
  # end

  # def test_the_items_method_returns_items_with_the_invoice_id
  #   assert_equal invoice.id, invoice.items[0].invoice_id.to_i
  #   assert_equal invoice.id, invoice.items[-1].invoice_id.to_i
  # end

  def test_it_has_a_customer_method
    assert invoice.customer
  end

  def test_the_customer_method_returns_assocaiated_customer
    assert_equal SalesEngine::Customer, invoice.customer.class
  end

  def test_the_customer_method_returns_customer_with_the_invoice_id
    assert_equal invoice.customer_id, invoice.customer.id.to_i
  end

  def test_it_has_a_merchant_method
    assert invoice.merchant
  end

  def test_the_items_method_returns_assocaiated_items
    assert_equal SalesEngine::Merchant, invoice.merchant.class
  end

  def test_the_items_method_returns_items_with_the_invoice_id
    assert_equal invoice.merchant_id, invoice.merchant.id.to_i
  end

end

