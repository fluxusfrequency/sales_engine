gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_accessor :database, :invoice_item_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @invoice_item_repository ||= database.invoice_item_repository
  end

  def test_it_should_exist
    assert !invoice_item_repository.nil?
  end

end