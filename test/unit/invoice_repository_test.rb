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

  def test_it_has_an_all_method_that_returns_an_array_of_invoice_objects
    result = invoice_repository.all
    assert_equal Array, result.class
    assert_equal SalesEngine::Invoice, result.last.class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    result = invoice_repository.random
    assert_equal SalesEngine::Invoice, result.class
    random_searches = []
    10.times { random_searches << invoice_repository.random }
    random_searches.reject {|s| s == invoice_repository.invoices[0]}
    assert random_searches.length > 2
  end

end