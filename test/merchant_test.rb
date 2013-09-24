gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/merchant.rb'

class MerchantTest < Minitest::Test

  attr_accessor :merchant

  def setup
    @merchant = Merchant.new(1, "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
  end

  def test
    true
  end

end
