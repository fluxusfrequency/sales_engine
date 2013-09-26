gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/merchant.rb'

class MerchantTest < Minitest::Test

  attr_accessor :merchant

  def setup
    data = {:id => 1,
            :name => "Schroeder-Jerde",
            :created_at => "2012-03-27 14:53:59 UTC",
            :updated_at => "2012-03-27 14:53:59 UTC"
            }

    @merchant = SalesEngine::Merchant.new(data, SalesEngine)
  end

  def test_it_returns_a_merchant_object
    assert_equal SalesEngine::Merchant, merchant.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, merchant.id
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_has_an_items_method
    assert merchant.items
  end

  def test_the_items_method_returns_assocaiated_items
    assert_equal SalesEngine::Item, merchant.items[0].class
  end

  def test_the_items_method_returns_items_with_the_merchant_id
    assert_equal merchant.id, merchant.items[0].merchant_id.to_i
    assert_equal merchant.id, merchant.items[-1].merchant_id.to_i
  end

  def test_it_has_an_invoices_method
    assert merchant.invoices
  end

  def test_the_invoice_method_returns_associated_invoices
    assert_equal SalesEngine::Invoice, merchant.invoices[0].class
  end

  def test_the_invoices_method_returns_invoices_with_the_merchant_id
    assert_equal merchant.id, merchant.invoices[0].merchant_id.to_i
    assert_equal merchant.id, merchant.invoices[-1].merchant_id.to_i
  end

  # def test_it_has_a_revenue_method
  #   assert merchant.revenue
  # end

  # def test_the_a_revenue_method_returns_a_big_decimal
  #   assert BigDecimal, merchant.revenue.class
  # end

end
