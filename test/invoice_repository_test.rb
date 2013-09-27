gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/invoice.rb'
require_relative '../lib/sales_engine/invoice_repository.rb'

class InvoiceRepositoryTest < Minitest::Test

  attr_accessor :invoice_repository

  def setup
    @invoice_repository = SalesEngine::InvoiceRepository.new('test/fixtures/invoice_repository_fixture.csv')
  end

  def test_it_has_an_attr_called_invoices
    assert invoice_repository.invoices
  end

  def test_the_invoice_array_contains_Invoice_objects
    assert_equal SalesEngine::Invoice, invoice_repository.invoices[0].class
  end

  def test_the_all_method_returns_loaded_items
    assert invoice_repository.all.length > 1
    assert_equal SalesEngine::Invoice, invoice_repository.all[0].class
    assert_equal SalesEngine::Invoice, invoice_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal SalesEngine::Invoice, invoice_repository.random.class
    random_searches = []
    10.times do
      random_searches << invoice_repository.random
    end
    random_searches.reject {|s| s == invoice_repository.invoices[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_invoice_repository_class
    assert_equal SalesEngine::InvoiceRepository, invoice_repository.class
  end

  def test_find_by_id_returns_an_invoice_with_the_correct_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_an_invoice_with_the_correct_id
    assert_equal 1, invoice_repository.find_all_by_id(1).first.id.to_i
  end

  def test_find_by_customer_id_returns_an_invoice_with_the_correct_customer_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_customer_id(1)
  end

  def test_find_all_by_customer_id_returns_an_invoice_with_the_correct_customer_id
    assert_equal 1, invoice_repository.find_all_by_customer_id(1).first.id.to_i
  end

  def test_find_by_merchant_id_returns_an_invoice_with_the_correct_merchant_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_merchant_id(26)
  end

  def test_find_all_by_merchant_id_returns_an_invoice_with_the_correct_merchant_id
    assert_equal 26, invoice_repository.find_all_by_merchant_id(26).first.merchant_id.to_i
  end

  def test_find_by_status_returns_an_invoice_with_the_correct_status
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_status("shipped")
  end

  def test_find_all_by_status_returns_an_invoice_with_the_correct_status
    assert_equal "shipped", invoice_repository.find_all_by_status("shipped").first.status
  end

  def test_find_by_created_at_returns_an_invoice_with_the_correct_created_at
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_created_at("2012-03-25 09:54:09 UTC")
  end

  def test_find_all_by_created_at_returns_an_invoice_with_the_correct_created_at
    assert_equal "2012-03-25 09:54:09 UTC", invoice_repository.find_all_by_created_at("2012-03-25 09:54:09 UTC").first.created_at
  end

  def test_find_by_updated_at_returns_an_invoice_with_the_correct_updated_at
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_updated_at("2012-03-25 09:54:09 UTC")
  end

  def test_find_all_by_updated_at_returns_an_invoice_with_the_correct_updated_at
    # binding.pry
    assert_equal "2012-03-25 09:54:09 UTC", invoice_repository.find_all_by_updated_at("2012-03-25 09:54:09 UTC").first.updated_at
  end

  def test_it_has_a_most_revenue_x_method
    assert invoice_repository.most_revenue(2)
  end

  def test_the_most_revenue_x_method_returns_an_array_of_items_sorted_by_revenue
    result = invoice_repository.most_revenue(2)
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.first.class
    # assert result.first.revenue_generated > result.last.revenue_generated
  end

end
