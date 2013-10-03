require 'csv'
require 'bigdecimal'
require 'time'

Dir["./lib/sales_engine/*.rb"].each do |file|
  require file
end

class SalesEngine

  attr_reader :dir
  def initialize(dir="./data")
    @dir = dir
  end

  def startup
    Database.startup(dir)
  end

  def customer_repository
    Database.customer_repository
  end

  def invoice_repository
    Database.invoice_repository
  end

  def invoice_item_repository
    Database.invoice_item_repository
  end

  def item_repository
    Database.item_repository
  end

  def merchant_repository
    Database.merchant_repository
  end

  def transaction_repository
    Database.transaction_repository
  end
end