gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_accessor :invoice_item_repository, :database

  def setup
    @database = SalesEngine::Database
    database.setup_stubs
    @invoice_item_repository = database.invoice_item_repository
  end

  def test_it_has_an_attr_called_invoice_items
    assert invoice_item_repository.invoice_items
  end

  def test_the_items_array_contains_InvoiceItem_objects
    assert_equal SalesEngine::InvoiceItem, invoice_item_repository.invoice_items[0].class
  end

  def test_the_all_method_returns_loaded_items
    assert invoice_item_repository.all.length > 1
    assert_equal SalesEngine::InvoiceItem, invoice_item_repository.all[0].class
    assert_equal SalesEngine::InvoiceItem, invoice_item_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal SalesEngine::InvoiceItem, invoice_item_repository.random.class
    random_searches = []
    10.times do
      random_searches << invoice_item_repository.random
    end
    random_searches.reject {|s| s == invoice_item_repository.invoice_items[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_invoice_item_repository_class
    assert_equal SalesEngine::InvoiceItemRepository, invoice_item_repository.class
  end

  def test_find_by_id_returns_an_invoice_item_with_the_correct_id
    assert_equal invoice_item_repository.invoice_items[0], invoice_item_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_an_invoice_item_with_the_correct_id
    assert_equal 1, invoice_item_repository.find_all_by_id(1).first.id.to_i
  end

  def test_find_by_item_id_returns_an_invoice_item_with_the_correct_item_id
    assert_equal invoice_item_repository.invoice_items[0], invoice_item_repository.find_by_item_id(13)
  end

  def test_find_all_by_item_id_returns_an_invoice_item_with_the_correct_item_id
    assert_equal 13, invoice_item_repository.find_all_by_item_id(13).first.item_id.to_i
  end

  def test_find_by_invoice_id_returns_an_invoice_item_with_the_correct_invoice_id
    assert_equal invoice_item_repository.invoice_items[0], invoice_item_repository.find_by_invoice_id(1)
  end

  def test_find_all_by_invoice_id_returns_an_invoice_item_with_the_correct_invoice_id
    assert_equal 1, invoice_item_repository.find_all_by_invoice_id(1).first.invoice_id.to_i
  end

  def test_find_by_quantity_returns_an_invoice_item_with_the_correct_quantity
    assert_equal invoice_item_repository.invoice_items[0], invoice_item_repository.find_by_quantity(5)
  end

  def test_find_all_by_quantity_returns_an_invoice_item_with_the_correct_quantity
    assert_equal 5, invoice_item_repository.find_all_by_quantity(5).first.quantity.to_i
  end

  def test_find_by_unit_price_returns_an_invoice_item_with_the_correct_unit_price
    assert_equal invoice_item_repository.invoice_items[0], invoice_item_repository.find_by_unit_price(13635)
  end

  def test_find_all_by_unit_price_returns_an_invoice_item_with_the_correct_unit_price
    assert_equal 13635, invoice_item_repository.find_all_by_unit_price(13635).first.unit_price.to_i
  end

  def test_find_by_created_at_returns_an_invoice_item_with_the_correct_created_at
    assert_equal invoice_item_repository.invoice_items[0], invoice_item_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
  end

  def test_find_all_by_created_at_returns_an_invoice_item_with_the_correct_created_at
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC").first.created_at
  end

  def test_find_by_updated_at_returns_an_invoice_item_with_the_correct_updated_at
    assert_equal invoice_item_repository.invoice_items[0], invoice_item_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
  end

  def test_find_all_by_updated_at_returns_an_invoice_item_with_the_correct_updated_at
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC").first.updated_at
  end
end
