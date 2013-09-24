gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/invoice.rb'
require_relative '../lib/sales_engine/invoice_repository.rb'

class InvoiceRepositoryTest < Minitest::Test

  attr_accessor :invoice_repository

  def setup
    @invoice_repository = InvoiceRepository.new('test/fixtures/item_repositoy_fixture.csv')
  end

  def test_it_has_an_attr_called_invoice
    assert invoice_repository.invoice
  end

  def test_populates_a_list_of_items
    assert invoice_repository.populate_list
  end

  def test_the_invoice_array_contains_Invoice_objects
    assert_equal Invoice, invoice_repository.invoice[0].class
  end

  def test_the_all_method_returns_loaded_items
    assert invoice_repository.all.length > 1
    assert_equal Invoice, invoice_repository.all[0].class
    assert_equal Invoice, invoice_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal Invoice, invoice_repository.random.class
    random_searches = []
    10.times do
      random_searches << invoice_repository.random
    end
    random_searches.reject {|s| s == invoice_repository.items[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_invoice_repository_class
    assert_equal InvoiceRepository, invoice_repository.class
  end
end
