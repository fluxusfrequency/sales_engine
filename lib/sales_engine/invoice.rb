require_relative '../sales_engine.rb'

class SalesEngine
  class Invoice

    attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_i
      @customer_id = data[:customer_id].to_i
      @merchant_id = data[:merchant_id].to_i
      @status = data[:status]
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def transactions
      Database.transaction_repository.find_all_by_invoice_id(id)
    end

    def invoice_items
      Database.invoice_item_repository.find_all_by_invoice_id(id)
    end

    def items
      @items ||= invoice_items.collect do |invoice_item|
        Database.item_repository.find_by_id(invoice_item.item_id)
      end
    end

    def customer
      Database.customer_repository.find_by_id(customer_id)
    end

    def merchant
      Database.merchant_repository.find_by_id(merchant_id)
    end

    def successful?
      if transactions
        transactions.any? {|transaction| transaction.result == "success"}
      end
    end

  end
end