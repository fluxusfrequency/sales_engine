require 'csv'
require 'bigdecimal'
require 'time'

Dir["./lib/sales_engine/*.rb"].each do |file|
  require file
end

class SalesEngine

  def initialize(dir="./data")
    startup(dir)
  end

  def startup(dir)
    Database.startup(dir)
  end

  def customer_repository
    @customer_repository ||= Database.customer_repository
  end

  def invoice_repository
    @invoice_repository ||= Database.invoice_repository
  end

  def invoice_item_repository
    @invoice_item_repository ||= Database.invoice_item_repository
  end

  def item_repository
    @item_repository ||= Database.item_repository
  end

  def merchant_repository
    @merchant_repository ||= Database.merchant_repository
  end

  def transaction_repository
    @transaction_repository ||= Database.transaction_repository
  end
end