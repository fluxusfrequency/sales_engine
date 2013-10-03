gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class CustomerRepositoryTest < Minitest::Test
  attr_accessor :database, :customer_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @customer_repository ||= database.customer_repository
  end

  def test_it_should_exist
    assert !customer_repository.nil?
  end

end