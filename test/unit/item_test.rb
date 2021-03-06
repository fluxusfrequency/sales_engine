gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class ItemsTest < Minitest::Test

  attr_accessor :database, :item

  def setup
    data = { :id => 13,
             :name => "Item Qui Esse",
             :description => "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
             :unit_price => 75107,
             :merchant_id => 1,
             :created_at => "2012-03-27 14:53:59 UTC",
             :updated_at => "2012-03-27 14:53:59 UTC"
             }
    @database = SalesEngine::Database
    database.startup_fixtures
    @item ||= SalesEngine::Item.new(data)
  end

  def test_it_should_exist
    assert !item.nil?
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::Item, item.class
  end

  def test_it_sets_up_attrs
    assert_equal 13, item.id
    assert_equal "Item Qui Esse", item.name
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item.description
    assert_equal BigDecimal.new(75107)/100, item.unit_price
    assert_equal 1, item.merchant_id
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), item.created_at
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), item.updated_at
  end

  def test_the_invoice_items_method_returns_associated_invoice_items
    result = item.invoice_items
    assert_equal SalesEngine::InvoiceItem, result.first.class
    assert_equal item.id, result.first.item_id.to_i
  end

  def test_the_merchant_method_returns_the_assocaiated_merchant
    assert SalesEngine::Merchant, item.merchant.class
    assert_equal item.merchant_id, item.merchant.id.to_i
  end

end