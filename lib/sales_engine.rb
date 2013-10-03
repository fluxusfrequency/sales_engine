require 'csv'
require 'bigdecimal'

Dir['./sales_engine/*.rb'].each do |file|
  require file
end

class SalesEngine

  attr_reader :data
  def initialize(data)
    @data = data
  end

  def startup
    SalesEngine::Database.startup(data)
  end

  def customer_repository
    SalesEngine::Database.customer_repository
  end

  def invoice_repository
    SalesEngine::Database.invoice_repository
  end

  def invoice_item_repository
    SalesEngine::Database.invoice_item_repository
  end

  def item_repository
    SalesEngine::Database.item_repository
  end

  def merchant_repository
    SalesEngine::Database.merchant_repository
  end

  def transaction_repository
    SalesEngine::Database.transaction_repository
  end
end