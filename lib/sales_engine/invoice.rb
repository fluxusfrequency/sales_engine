require_relative '../sales_engine.rb'

class SalesEngine
  class Invoice

    attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id]
      @customer_id = data[:customer_id]
      @merchant_id = data[:merchant_id]
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

  end
end