gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class CustomerTest < Minitest::Test

  attr_accessor :database, :customer_repository

  def initialize
    @database = SalesEngine::Database
    database.startup_fixtures
    @customer_repository ||= database.customer_repository
  end

  def test_it_should_exist
    assert customer_repositcustomers.first.exist?
  end

end