gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class TransactionsTest < Minitest::Test

  attr_accessor :database, :transaction_repository

  def initialize()
    @database = SalesEngine::Database
    database.startup_fixtures
    @transacation_repository ||= database.transacation_repository
  end

end