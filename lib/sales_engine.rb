require 'csv'
require 'bigdecimal'
require 'time'

Dir["./lib/sales_engine/*.rb"].each do |file|
  require file
end

class SalesEngine

  attr_reader :customer_repository, :invoice_repository, :invoice_item_repository, :item_repository, :merchant_repository, :transaction_repository

  def initialize(dir="./data")
    startup(dir)
    @customer_repository ||= Database.customer_repository
    @invoice_repository ||= Database.invoice_repository
    @invoice_item_repository ||= Database.invoice_item_repository
    @item_repository ||= Database.item_repository
    @merchant_repository ||= Database.merchant_repository
    @transaction_repository ||= Database.transaction_repository
  end

  def startup(dir)
    Database.startup(dir)
  end

end