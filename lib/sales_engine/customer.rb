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

    # def favorite_merchant
    #   returns an instance of Merchant where the customer has conducted the most successful transactions
    # end

  end
end
