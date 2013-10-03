gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class TransactionRepositoryTest < Minitest::Test
  attr_accessor :database, :transaction_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @transaction_repository ||= database.transaction_repository
  end

  def test_it_should_exist
    assert !transaction_repository.nil?
  end

  def test_it_should_have_an_attr_called_transactions_that_returns_an_array_of_transaction_objects
    result = transaction_repository.transactions
    assert_equal Array, result.class
    assert_equal SalesEngine::Transaction, result.first.class
  end

  def test_it_has_an_all_method_that_returns_an_array_of_transaction_objects
    result = transaction_repository.all
    assert_equal Array, result.class
    assert_equal SalesEngine::Transaction, result.last.class
  end

end