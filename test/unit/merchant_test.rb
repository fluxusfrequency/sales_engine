gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'

class TransactionsTest < Minitest::Test

  attr_accessor :database

  def initialize
    @database = SalesEngine::Database
    database.startup_fixtures
    @merchant_repository ||= database.merchant_repository
  end

end