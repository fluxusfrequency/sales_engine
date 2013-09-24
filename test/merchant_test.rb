gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/merchant.rb'

class MerchantTest < Minitest::Test

  attr_accessor :merchant

  def setup
    data = {:id => 1, :name => "Schroeder-Jerde", :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"}
    @merchant = Merchant.new(data)
  end

  def test_it_returns_a_merchant_object
    assert_equal Merchant, merchant.class
  end

  def test_it_sets_up_attrs
    assert_equal 1, merchant.id
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_has_an_invoices_method
    assert true, merchant.invoices
  end

  def test_the_invoice_method_returns_associated_invoices
  end

  def test_it_has_an_items_method
    assert true, merchant.items
  end

  def test_the_items_method_returns_assocaiated_items
  end

  def test_it_has_a_revenue_method
    assert true, merchant.revenue
  end

end
