gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/item.rb'

class ItemTest < Minitest::Test

  attr_accessor :item

  def setup
    data = {:id => 1,
            :name => "Item Qui Esse",
            :description => "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
            :unit_price => 75107,
            :merchant_id => 1,
            :created_at => "2012-03-27 14:53:59 UTC",
            :updated_at => "2012-03-27 14:53:59 UTC"
            }

    @item = Item.new(data)
  end

  def test_it_returns_an_item_object
    assert_equal Item, item.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, item.id
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
    assert InvoiceItem, arr[0].class
  end

  # WAIT UNTIL LOUISA UPDATES INVOICE ITEM REPO
  # def test_it_has_an_invoice_items_method
  #   assert item.invoice_items
  # end

  # def test_the_invoice_items_method_returns_associated_invoice_items
  #   assert_equal InvoiceItem, item.invoice_items[0].class
  # end

  # def test_the_invoice_items_method_returns_invoice_items_with_the_item_id
  #   assert_equal item.invoice_items_id, item.invoice_items[0].id.to_i
  # end

  def test_it_has_a_merchant_method
    assert item.merchant
  end

  def test_the_merchant_method_returns_the_assocaiated_merchant
    assert Merchant, item.merchant.class
  end

  def test_the_merchant_method_returns_the_merchant_with_the_item_id
    assert_equal item.merchant_id, item.merchant.id.to_i
  end

end
