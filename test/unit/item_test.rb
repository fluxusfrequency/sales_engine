gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class TransactionsTest < Minitest::Test

  attr_accessor :database, :item_repository

  def initialize
    @database = SalesEngine::Database
    database.startup_fixtures
    @item_repository ||= database.item_repository
  end

end