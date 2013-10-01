require 'time'
require 'csv'
require 'bigdecimal'

Dir["./lib/sales_engine/*.rb"].each do |file|
  require file
end

class SalesEngine
  def initialize(dir="./data")
    startup(dir)
  end

  def startup(dir)
    SalesEngine::Database.load_data(dir)
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
