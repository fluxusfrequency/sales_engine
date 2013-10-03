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

  def test_it_should_have_an_attr_called_invoice_items_that_returns_an_array_of_invoice_item_objects
    result = invoice_item_repository.invoice_items
    assert_equal Array, result.class
    assert_equal SalesEngine::InvoiceItem, result.first.class
  end

  def test_it_has_an_all_method_that_returns_an_array_of_invoice_item_objects
    result = invoice_item_repository.all
    assert_equal Array, result.class
    assert_equal SalesEngine::InvoiceItem, result.last.class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    result = invoice_item_repository.random
    assert_equal SalesEngine::InvoiceItem, result.class
    random_searches = []
    10.times { random_searches << invoice_item_repository.random }
    random_searches.reject {|s| s == invoice_item_repository.invoice_items[0]}
    assert random_searches.length > 2
  end

  def test_it_has_a_find_by_id_method_that_returns_an_invoice_item_with_the_matching_id
    result = invoice_item_repository.find_by_id(1)
    assert_equal SalesEngine::InvoiceItem, result.class
    assert_equal 1, result.id.to_i
  end

  def test_it_has_a_find_all_by_id_method_that_returns_an_array_of_invoice_items_with_the_matching_id
    result = invoice_item_repository.find_all_by_id(1)
    assert_equal Array, result.class
    assert_equal SalesEngine::InvoiceItem, result.first.class
    assert_equal 1, result.last.id.to_i
  end

  def test_it_has_a_find_by_invoice_id_method_that_returns_an_invoice_with_the_matching_id
    result = invoice_item_repository.find_by_invoice_id(2)
    assert_equal SalesEngine::InvoiceItem, result.class
    assert_equal 2, result.invoice_id.to_i
  end

  def test_it_has_a_find_all_by_invoice_id_method_that_returns_an_array_of_invoices_with_the_matching_id
    result = invoice_item_repository.find_all_by_invoice_id(2)
    assert_equal Array, result.class
    assert_equal SalesEngine::InvoiceItem, result.first.class
    assert_equal 2, result.last.invoice_id.to_i
  end

end