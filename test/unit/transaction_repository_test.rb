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

end