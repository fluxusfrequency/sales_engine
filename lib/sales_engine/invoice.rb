require_relative '../sales_engine.rb'

class SalesEngine
  class Invoice
    attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :engine

    def initialize(data={}, engine)
      @id = data[:id]
      @customer_id = data[:customer_id].to_i
      @merchant_id = data[:merchant_id]
      @status = data[:status]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
      @engine = engine
    end

    def transactions
      SalesEngine::Database.transaction_repository.find_all_by_invoice_id(id.to_i)
    end

    def invoice_items
      SalesEngine::Database.invoice_item_repository.find_all_by_invoice_id(id)
    end

    def items
      result ||= invoice_items.collect do |invoice_item|
        SalesEngine::Database.item_repository.find_by_id(invoice_item.item_id)
      end
    end

    def customer
      SalesEngine::Database.customer_repository.find_by_id(customer_id)
    end

    def merchant
      SalesEngine::Database.merchant_repository.find_by_id(merchant_id)
    end

    def successful?
      if transactions
        transactions.any? {|transaction| transaction.result == "success" }
      end
    end

    def pending?
      !successful?
    end

    def successful_transactions
      transactions.select do |transaction|
        transaction.result == "success"
      end
    end

    def failed_transactions
      transactions.select do |transaction|
        transaction.result == "failed"
      end
    end

    def charge(data={})
      SalesEngine::Database.invoice_repository.create(params_for_invoice)
      SalesEngine::Database.transaction_repository.create(params_for_transaction(data))
    end

    def total
      invoice_items.map { |invoice_item| invoice_item.total }.inject(0,:+)
    end

    private

    def params_for_invoice
      {:id => SalesEngine::Database.find_last_invoice.id.to_i+1,
      :customer => customer,
      :merchant => merchant,
      :status => status,
      :created_at => created_at,
      :updated_at => updated_at }
    end

    def params_for_transaction(data)
      { :id => SalesEngine::Database.find_last_transaction.id.to_i+1,
        :invoice_id => id.to_s,
        :credit_card_number => data[:credit_card_number],
        :credit_card_expiration_date => '',
        :result => data[:result],
        :created_at => created_at,
        :updated_at => updated_at }
    end

  end
end
