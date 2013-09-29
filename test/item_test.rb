gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/sales_engine/item.rb'

class ItemTest < Minitest::Test

  attr_accessor :item, :database

  def setup
    data = {:id => 13,
            :name => "Item Qui Esse",
            :description => "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
            :unit_price => 75107,
            :merchant_id => 1,
            :created_at => "2012-03-27 14:53:59 UTC",
            :updated_at => "2012-03-27 14:53:59 UTC"
            }

    @item = SalesEngine::Item.new(data, SalesEngine)
    @database = SalesEngine::Database
    database.setup_stubs
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::Item, item.class
  end

  def test_it_sets_up_attrs
    assert_equal 13, item.id
    assert_equal "Item Qui Esse", item.name
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item.description
    assert_equal 75107, item.unit_price
    assert_equal 1, item.merchant_id
    assert_equal "2012-03-27 14:53:59 UTC", item.created_at
    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
  end

  def test_it_has_an_invoice_items_method
    assert item.invoice_items
  end

  def test_the_invoice_items_method_returns_assocaiated_invoice_items
    arr = item.invoice_items
    assert SalesEngine::InvoiceItem, arr[0].class
  end

  def test_it_has_an_invoice_items_method
    assert item.invoice_items
  end

  def test_the_invoice_items_method_returns_associated_invoice_items
    assert_equal SalesEngine::InvoiceItem, item.invoice_items[0].class
  end

  def test_the_invoice_items_method_returns_invoice_items_with_the_item_id
    found_items = item.invoice_items
    assert_equal item.id, found_items[0].item_id.to_i
  end

  def test_the_merchant_method_returns_the_assocaiated_merchant
    assert SalesEngine::Merchant, item.merchant.class
  end

  def test_the_merchant_method_returns_the_merchant_with_the_item_id
    assert_equal item.merchant_id, item.merchant.id.to_i
  end

  def test_the_best_day_method_returns_a_date
    assert item.best_day.match(/\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s\w{3}/)[0]
  end

  def test_the_revenue_generated_method_returns_a_big_decimal
    assert_equal BigDecimal, item.revenue_generated.class
  end

  def test_the_items_sold_method_returns_a_number
    assert_equal Fixnum, item.number_sold.class
  end
end
