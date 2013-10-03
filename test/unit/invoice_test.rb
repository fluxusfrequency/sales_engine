gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class InvoiceTest < Minitest::Test

  attr_accessor :database, :invoice

  def setup
    data = { :id => 1,
             :customer_id => 1,
             :merchant_id => 3,
             :status => "shipped",
             :created_at => "2012-03-25 09:54:09 UTC",
             :updated_at => "2012-03-25 09:54:09 UTC"
             }

    @database = SalesEngine::Database
    database.startup_fixtures
    @invoice ||= SalesEngine::Invoice.new(data)
  end

  def test_it_should_exist
    assert !invoice.nil?
  end

end