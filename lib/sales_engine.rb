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
    merchant_repo ||= MerchantRepository.new(load_for("merchants"))
    merchant_repo
  end

  def self.invoice_repository
    invoice_repo ||= InvoiceRepository.new(load_for("invoices"))
    invoice_repo
  end

  def self.item_repository
    item_repo ||= ItemRepository.new(load_for("items"))
    item_repo
  end

  def self.invoice_item_repository
    invoice_item_repo ||= InvoiceItemRepository.new(load_for("invoice_items"))
    invoice_item_repo
  end

  def self.customer_repository
    customer_repo ||= CustomerRepository.new(load_for("customers"))
    customer_repo
  end

  def self.transaction_repository
    transaction_repo ||= TransactionRepository.new(load_for("transactions"))
    transaction_repo
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
