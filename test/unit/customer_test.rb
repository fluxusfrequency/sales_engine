gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class CustomerTest < Minitest::Test
  attr_accessor :database, :customer

  def setup
    data = { :id => 1,
             :first_name => "Joey",
             :last_name => "Ondricka",
             :created_at => "2012-03-27 14:54:09 UTC",
             :updated_at => "2012-03-27 14:54:09 UTC"
             }

    @database = SalesEngine::Database
    database.startup_fixtures
    @customer ||= SalesEngine::Customer.new(data)
  end

  def test_it_should_exist
    assert !customer.nil?
  end

end