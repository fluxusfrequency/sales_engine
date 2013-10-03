gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class MerchantTest < Minitest::Test

  attr_accessor :database, :merchant

  def setup
    data = { :id => 1,
             :name => "Schroeder-Jerde",
             :created_at => "2012-03-27 14:53:59 UTC",
             :updated_at => "2012-03-27 14:53:59 UTC"
             }

    @database = SalesEngine::Database
    database.startup_fixtures
    @merchant ||= SalesEngine::Merchant.new(data)
  end

  def test_it_should_exist
    assert !merchant.nil?
  end

  def test_it_returns_an_item_object
    assert_equal SalesEngine::Merchant, merchant.class
  end

end