require_relative '../sales_engine.rb'

class SalesEngine
  class InvoiceItem

    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :engine

    def initialize(data={}, engine)
      @id = data[:id]
      @item_id = data[:item_id]
      @invoice_id = data[:invoice_id]
      @quantity = data[:quantity]
      @unit_price = data[:unit_price]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
      @engine = engine
    end

    def invoice
      SalesEngine::Database.invoice_repository.find_by_id(invoice_id)
    end

    def item
      SalesEngine::Database.item_repository.find_by_id(item_id)
    end

    def total
      unit_price.to_i * quantity.to_i
    end

  end
end
