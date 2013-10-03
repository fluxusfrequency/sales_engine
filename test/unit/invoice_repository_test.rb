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

  def test_it_should_have_an_attr_called_invoices_that_returns_an_array_of_invoice_objects
    result = invoice_repository.invoices
    assert_equal Array, result.class
    assert_equal SalesEngine::Invoice, result.first.class
  end

end