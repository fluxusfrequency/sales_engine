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

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    result = transaction_repository.random
    assert_equal SalesEngine::Transaction, result.class
    random_searches = []
    10.times { random_searches << transaction_repository.random }
    random_searches.reject {|s| s == transaction_repository.transactions[0]}
    assert random_searches.length > 2
  end

  def test_it_has_a_find_by_id_method_that_returns_a_transaction_with_the_matching_id
    result = transaction_repository.find_by_id(7)
    assert_equal SalesEngine::Transaction, result.class
    assert_equal 7, result.id.to_i
  end

  def test_it_has_a_find_all_by_id_method_that_returns_an_array_of_transactions_with_the_matching_id
    result = transaction_repository.find_all_by_id(7)
    assert_equal Array, result.class
    assert_equal SalesEngine::Transaction, result.first.class
    assert_equal 7, result.last.id.to_i
  end

  def test_it_has_a_find_by_invoice_id_method_that_returns_a_transaction_with_the_matching_id
    result = transaction_repository.find_by_invoice_id(11)
    assert_equal SalesEngine::Transaction, result.class
    assert_equal 11, result.invoice_id.to_i
  end

  def test_it_has_a_find_all_by_invoice_id_method_that_returns_an_array_of_transactions_with_the_matching_id
    result = transaction_repository.find_all_by_invoice_id(11)
    assert_equal Array, result.class
    assert_equal SalesEngine::Transaction, result.last.class
    assert_equal 11, result.last.invoice_id.to_i
  end

  def test_it_has_a_find_by_credit_card_number_method_that_returns_a_transaction_with_the_matching_id
    result = transaction_repository.find_by_credit_card_number("4540842003561938")
    assert_equal SalesEngine::Transaction, result.class
    assert_equal "4540842003561938", result.credit_card_number
  end

  def test_it_has_a_find_all_by_credit_card_number_method_that_returns_an_array_of_transactions_with_the_matching_id
    result = transaction_repository.find_all_by_credit_card_number("4540842003561938")
    assert_equal Array, result.class
    assert_equal SalesEngine::Transaction, result.last.class
    assert_equal "4540842003561938", result.last.credit_card_number
  end

  def test_it_has_a_find_by_result_method_that_returns_a_transaction_with_the_matching_id
    result = transaction_repository.find_by_result("success")
    assert_equal SalesEngine::Transaction, result.class
    assert_equal "success", result.result
  end

  def test_it_has_a_find_all_by_result_method_that_returns_an_array_of_transactions_with_the_matching_id
    result = transaction_repository.find_all_by_result("success")
    assert_equal Array, result.class
    assert_equal SalesEngine::Transaction, result.last.class
    assert_equal "success", result.last.result
  end

  def test_it_has_a_find_by_created_at_method_that_returns_a_transaction_with_the_matching_id
    result = transaction_repository.find_by_created_at(Date.parse("2012-03-27 14:54:10 UTC"))
    assert_equal SalesEngine::Transaction, result.class
    assert_equal Date.parse("2012-03-27 14:54:10 UTC"), result.created_at
  end

  def test_it_has_a_find_all_by_created_at_method_that_returns_an_array_of_transactions_with_the_matching_id
    result = transaction_repository.find_all_by_created_at(Date.parse("2012-03-27 14:54:10 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Transaction, result.last.class
    assert_equal Date.parse("2012-03-27 14:54:10 UTC"), result.last.created_at
  end

  def test_it_has_a_find_by_updated_at_method_that_returns_an_invoice_itm_with_the_matching_id
    result = transaction_repository.find_by_updated_at(Date.parse("2012-03-27 14:54:10 UTC"))
    assert_equal SalesEngine::Transaction, result.class
    assert_equal Date.parse("2012-03-27 14:54:10 UTC"), result.updated_at
  end

  def test_it_has_a_find_all_by_updated_at_method_that_returns_an_array_of_transactions_with_the_matching_id
    result = transaction_repository.find_all_by_updated_at(Date.parse("2012-03-27 14:54:10 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Transaction, result.last.class
    assert_equal Date.parse("2012-03-27 14:54:10 UTC"), result.last.updated_at
  end

end