Dir["./lib/sales_engine/*.rb"].each do |file|
  require file
end

class SalesEngine
  def self.startup

  end

  def self.load_for(klass)
    "./data/#{klass}.csv"
  end

  def self.merchant_repository
    MerchantRepository.new(load_for("merchants"))
  end

  def self.invoice_repository
    InvoiceRepository.new(load_for("invoices"))
  end

  def self.item_repository
    ItemRepository.new(load_for("items"))
  end

  def self.invoice_item_repository
    InvoiceItemRepository.new(load_for("invoice_items"))
  end

  def self.customer_repository
    CustomerRepository.new(load_for("customers"))
  end

  def self.transaction_repository
    TransactionRepository.new(load_for("transactions"))
  end

end

# solution to DB problem: create a singleton class called Database
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
