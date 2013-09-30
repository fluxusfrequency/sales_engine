Dir["./lib/sales_engine/*.rb"].each do |file|
  require file
end

class SalesEngine
  attr_reader :file

  def initialize(file)
    @file = file
    startup
  end

  def startup
    SalesEngine::Database.setup
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

# Jeff's solution to DB problem: create a singleton class called Database
# class Database
#   def items
#     @items ||= ItemRepository.new
#   end
# end
#
# call it from the merchant instance:
# Database.items
#
#
# This is a global variable, which is bad because it will reference whichever DB was loaded last
# If you instantiate it, you have to pass it down the chain anyway
