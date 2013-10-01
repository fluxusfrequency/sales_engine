gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'

class TransactionRepositoryTest < Minitest::Test

  attr_accessor :transaction_repository, :database

  def setup
    @database = SalesEngine::Database
    database.setup_stubs
    @transaction_repository = database.transaction_repository
  end

  def test_it_has_an_attr_called_transactions
    assert transaction_repository.transactions
  end

  def test_the_transactions_array_contains_transaction_objects
    assert_equal SalesEngine::Transaction, transaction_repository.transactions[0].class
  end

  def test_the_all_method_returns_loaded_transactions
    assert transaction_repository.all.length > 1
    assert_equal SalesEngine::Transaction, transaction_repository.all[0].class
    assert_equal SalesEngine::Transaction, transaction_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_transaction_from_the_loaded_transactions
    assert_equal SalesEngine::Transaction, transaction_repository.random.class
    random_searches = []
    10.times do
      random_searches << transaction_repository.random
    end
    random_searches.reject {|s| s == transaction_repository.transactions[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_transaction_repository_class
    assert_equal SalesEngine::TransactionRepository, transaction_repository.class
  end

  def test_find_by_id_returns_a_transaction_with_the_correct_id
    assert_equal transaction_repository.transactions[0], transaction_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_a_transaction_with_the_correct_id
    assert_equal 2, transaction_repository.find_all_by_id(2).first.id.to_i
  end

  def test_find_by_invoice_id_returns_a_transaction_with_the_correct_invoice_id
    assert_equal transaction_repository.transactions[0], transaction_repository.find_by_invoice_id(1)
  end

  def test_find_all_by_invoice_id_returns_a_transaction_with_the_correct_invoice_id
    assert_equal 1, transaction_repository.find_all_by_invoice_id(1).first.id.to_i
  end

  def test_find_by_credit_card_number_returns_a_transaction_with_the_correct_credit_card_number
    assert_equal transaction_repository.transactions[0], transaction_repository.find_by_credit_card_number(4654405418249632)
  end

  def test_find_all_by_credit_card_number_returns_a_transaction_with_the_correct_credit_card_number
    assert_equal 4654405418249632, transaction_repository.find_all_by_credit_card_number(4654405418249632).first.credit_card_number.to_i
  end

  def test_find_by_result_returns_a_transaction_with_the_correct_result
    assert_equal transaction_repository.transactions[0], transaction_repository.find_by_result("success")
  end

  def test_find_all_by_result_returns_a_transaction_with_the_correct_result
    assert_equal "success", transaction_repository.find_all_by_result("success").first.result
  end

  def test_find_by_created_at_returns_a_transaction_with_the_correct_created_at
    assert_equal transaction_repository.transactions[0], transaction_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
  end

  def test_find_all_by_created_at_returns_a_transaction_with_the_correct_created_at
    assert_equal "2012-03-27 14:54:09 UTC", transaction_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC").first.created_at
  end

  def test_find_by_updated_at_returns_a_transaction_with_the_correct_updated_at
    assert_equal transaction_repository.transactions[0], transaction_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
  end

  def test_find_all_by_updated_at_returns_a_transaction_with_the_correct_updated_at
    assert_equal "2012-03-27 14:54:09 UTC", transaction_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC").first.updated_at
  end

  def test_it_has_a_create_function_that_takes_a_hash_of_parameters
    params_hash = {:id => SalesEngine::Database.find_last_transaction.id.to_i+1,
                  :invoice_id => 15,
                  :credit_card_number => '4444333322221111',
                  :credit_card_expiration_date => '10/13',
                  :result => 'success',
                  :created_at => "2012-03-27 14:54:09 UTC",
                  :updated_at => "2012-03-27 14:54:09 UTC"
                  }

    assert SalesEngine::Database.transaction_repository.create(params_hash)
  end

end
