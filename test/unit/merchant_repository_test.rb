gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class MerchantRepositoryTest < Minitest::Test
  attr_accessor :database, :merchant_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @merchant_repository ||= database.merchant_repository
  end

  def test_it_should_exist
    assert !merchant_repository.nil?
  end

end