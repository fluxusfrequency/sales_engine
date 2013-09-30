require_relative '../sales_engine.rb'

class SalesEngine
  class Customer
    attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :engine

    def initialize(data={}, engine)
      @id = data[:id]
      @first_name = data[:first_name]
      @last_name = data[:last_name]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
      @engine = engine
    end

    def invoices
      SalesEngine::Database.invoice_repository.find_all_by_customer_id(id)
    end

    def transactions
      transactions = []
      invoices.each do |invoice|
        SalesEngine::Database.transaction_repository.find_all_by_invoice_id(id).each do |invoice|
          transactions << invoice
        end
      end
      transactions
    end

    def favorite_merchant
    # returns an instance of Merchant where the customer has conducted the most successful transactions

    # find the associated merchants:
    # find the customer's invoices
    # use the invoice to find the merchant
    # use merchant.find_successful_invoices
    # select the customer's invoices from the successful_invoices using invoice.customer
    # create a hash that has this form: :merchant => number_of_successful_invoices
    # return the first key of the hash

      my_invoices = transactions.collect do |transaction|
        transaction.invoice
      end

      my_merchants = my_invoices.collect do |invoice|
        invoice.merchant
      end

      merchants_successful_invoices = []
      my_merchants.collect do |merchant|
        merchant.find_successful_invoices.each do |invoice|
          merchants_successful_invoices << invoice
        end
      end

      my_successful_invoices = merchants_successful_invoices.select do |invoice|
        invoice.customer_id == id.to_s
      end

      merchant_count = Hash.new(0)
      my_successful_invoices.each_with_object(merchant_count) do |invoice|
        merchant_count[invoice.merchant] += 1
      end

      merchant_count.keys.sort.reverse.first
    end

  end
end
