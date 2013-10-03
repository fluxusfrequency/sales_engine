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

  def test_it_has_a_find_by_id_method_that_returns_an_invoice_with_the_matching_id
    result = invoice_repository.find_by_id(6)
    assert_equal SalesEngine::Invoice, result.class
    assert_equal 6, result.id.to_i
  end

  def test_it_has_a_find_all_by_id_method_that_returns_an_array_of_invoices_with_the_matching_id
    result = invoice_repository.find_all_by_id(6)
    assert_equal Array, result.class
    assert_equal SalesEngine::Invoice, result.first.class
    assert_equal 6, result.last.id.to_i
  end

  def test_it_has_a_find_by_customer_id_method_that_returns_an_invoice_with_the_matching_customer_id
    result = invoice_repository.find_by_customer_id(1)
    assert_equal SalesEngine::Invoice, result.class
    assert_equal 1, result.customer_id.to_i
  end

  def test_it_has_a_find_all_by_customer_id_method_that_returns_an_array_of_invoices_with_the_matching_customer_id
    result = invoice_repository.find_all_by_customer_id(1)
    assert_equal Array, result.class
    assert_equal SalesEngine::Invoice, result.last.class
    assert_equal 1, result.last.customer_id.to_i
  end

  def test_it_has_a_find_by_merchant_id_method_that_returns_an_invoice_with_the_matching_id
    result = invoice_repository.find_by_merchant_id(33)
    assert_equal SalesEngine::Invoice, result.class
    assert_equal 33, result.merchant_id.to_i
  end

  def test_it_has_a_find_all_by_merchant_id_method_that_returns_an_array_of_invoices_with_the_matching_id
    result = invoice_repository.find_all_by_merchant_id(33)
    assert_equal Array, result.class
    assert_equal SalesEngine::Invoice, result.last.class
    assert_equal 33, result.last.merchant_id.to_i
  end

  def test_it_has_a_find_by_status_method_that_returns_an_invoice_itm_with_the_matching_id
    result = invoice_repository.find_by_status("shipped")
    assert_equal SalesEngine::Invoice, result.class
    assert_equal "shipped", result.status
  end

  def test_it_has_a_find_all_by_status_method_that_returns_an_array_of_invoices_with_the_matching_id
    result = invoice_repository.find_all_by_status("shipped")
    assert_equal Array, result.class
    assert_equal SalesEngine::Invoice, result.last.class
    assert_equal "shipped", result.last.status
  end

  def test_it_has_a_find_by_created_at_method_that_returns_an_invoice_itm_with_the_matching_id
    result = invoice_repository.find_by_created_at(Date.parse("2012-03-07 19:54:10 UTC"))
    assert_equal SalesEngine::Invoice, result.class
    assert_equal Date.parse("2012-03-07 19:54:10 UTC"), result.created_at
  end

  def test_it_has_a_find_all_by_created_at_method_that_returns_an_array_of_invoices_with_the_matching_id
    result = invoice_repository.find_all_by_created_at(Date.parse("2012-03-07 19:54:10 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Invoice, result.last.class
    assert_equal Date.parse("2012-03-07 19:54:10 UTC"), result.last.created_at
  end

  def test_it_has_a_find_by_updated_at_method_that_returns_an_invoice_itm_with_the_matching_id
    result = invoice_repository.find_by_updated_at(Date.parse("2012-03-07 19:54:10 UTC"))
    assert_equal SalesEngine::Invoice, result.class
    assert_equal Date.parse("2012-03-07 19:54:10 UTC"), result.updated_at
  end

  def test_it_has_a_find_all_by_updated_at_method_that_returns_an_array_of_invoices_with_the_matching_id
    result = invoice_repository.find_all_by_updated_at(Date.parse("2012-03-07 19:54:10 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Invoice, result.last.class
    assert_equal Date.parse("2012-03-07 19:54:10 UTC"), result.last.updated_at
  end

end