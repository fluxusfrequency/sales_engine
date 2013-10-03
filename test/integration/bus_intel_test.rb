gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class BusinessIntelligenceTest < Minitest::Test

  attr_accessor :database, :customer_repository, :invoice_repository, :invoice_item_repository, :item_repository, :merchant_repository, :transaction_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @customer_repository ||= database.customer_repository
    @invoice_repository ||= database.invoice_repository
    @invoice_item_repository ||= database.invoice_item_repository
    @item_repository ||= database.item_repository
    @merchant_repository ||= database.merchant_repository
    @transacation_repository ||= database.transacation_repository
  end

end