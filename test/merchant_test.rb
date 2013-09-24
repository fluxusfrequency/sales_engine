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

end
