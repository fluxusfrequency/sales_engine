gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class InvoiceRepositoryTest < Minitest::Test
  attr_accessor :database, :invoice_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @invoice_repository ||= database.invoice_repository
  end

  def test_it_should_exist
    assert !invoice_repository.nil?
  end

end