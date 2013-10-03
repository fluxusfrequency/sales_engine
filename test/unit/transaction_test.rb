gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class TransactionTest < Minitest::Test

  attr_accessor :database, :transaction

  def setup
    data = { :id => 1,
             :invoice_id => 1,
             :credit_card_number => 4654405418249632,
             :credit_card_expiration_date => "",
             :result => "success",
             :created_at => "2012-03-27 14:54:09 UTC",
             :updated_at => "2012-03-27 14:54:09 UTC"
             }

    @database = SalesEngine::Database
    database.startup_fixtures
    @transaction ||= SalesEngine::Transaction.new(data)
  end

  def test_it_should_exist
    assert !transaction.nil?
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::Transaction, transaction.class
  end

end