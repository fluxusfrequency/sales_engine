gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/invoice_item.rb'
require_relative '../lib/sales_engine/invoice_item_repository.rb'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_accessor :invoice_item_repository

  def setup
    @invoice_item_repository = InvoiceItemRepository.new('test/fixtures/item_repository_fixture.csv')
  end

  def test_it_has_an_attr_called_invoice_items
    assert invoice_item_repository.invoice_items
  end

  def test_populated_a_list_of_items
    assert invoice_item_repository.populate_list
  end

  def test_the_items_array_contains_InvoiceItem_objects
    assert_equal InvoiceItem, invoice_item_repository.invoice_items[0].class
  end

  def test_the_all_method_returns_loaded_items
    assert invoice_item_repository.all.length > 1
    assert_equal InvoiceItem, invoice_item_repository.all[0].class
    assert_equal InvoiceItem, invoice_item_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal InvoiceItem, invoice_item_repository.random.class
    random_searches = []
    10.times do
      random_searches << invoice_item_repository.random
    end
    random_searches.reject {|s| s == invoice_item_repository.invoice_items[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_invoice_item_repository_class
    assert_equal InvoiceItemRepository, invoice_item_repository.class
  end
end
