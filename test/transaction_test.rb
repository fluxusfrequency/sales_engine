gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'

class TransactionTest < Minitest::Test
  attr_accessor :transaction, :database

  def setup
    data = {:id => 1,
            :invoice_id => 1,
            :credit_card_number => 4654405418249632,
            :credit_card_expiration_date => "",
            :result => "success",
            :created_at => "2012-03-27 14:54:09 UTC",
            :updated_at => "2012-03-27 14:54:09 UTC"
            }

    @transaction = SalesEngine::Transaction.new(data, SalesEngine)
    @database = SalesEngine::Database
    database.setup_stubs
  end

  def test_it_returns_a_transaction_object
    assert_equal SalesEngine::Transaction, transaction.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 4654405418249632, transaction.credit_card_number
    assert_equal "", transaction.credit_card_expiration_date
    assert_equal "success", transaction.result
    assert_equal "2012-03-27 14:54:09 UTC", transaction.created_at
    assert_equal "2012-03-27 14:54:09 UTC", transaction.updated_at
  end

  def test_it_has_an_invoice_method
    assert transaction.invoice
  end

  def test_the_invoice_method_returns_an_associated_invoice
    assert_equal SalesEngine::Invoice, transaction.invoice.class
  end

  def test_the_invoice_method_returns_an_invoice_with_the_transaction_id
    # binding.pry
    assert_equal transaction.invoice_id, transaction.invoice.id.to_i
  end

end
