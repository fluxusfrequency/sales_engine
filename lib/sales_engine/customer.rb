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

    def merchants
      my_merchants = []
      invoices.each do |invoice|
        my_merchants << invoice.merchant unless invoice.merchant.nil?
      end
      my_merchants
    end

    def transactions
      transactions = []
      invoices.each do |invoice|
        SalesEngine::Database.transaction_repository.find_all_by_invoice_id(invoice.id).each do |transaction|
          transactions << transaction
        end
      end
      transactions
    end

    def successful_customer_invoices
      successes = successful_merchant_invoices.select do |invoice|
        invoice.customer_id == id.to_s
      end
      successes.flatten
    end

    def successful_merchant_invoices
      merchants.collect { |merchant| merchant.successful_invoices }.flatten
    end

    def favorite_merchant
      merchant_count = Hash.new(0)
      successful_customer_invoices.each_with_object(merchant_count) do |invoice|
        merchant_count[invoice.merchant] += 1
      end

      sorted_hash = merchant_count.sort_by {|merchant, count| count}.reverse
      sorted_hash.first.first
    end

  end
end
