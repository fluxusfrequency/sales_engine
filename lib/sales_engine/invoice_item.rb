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
      inv_repo = engine.invoice_repository
      result ||= inv_repo.find_by_id(invoice_id)
    end

    def item
      item_repo = engine.item_repository
      result ||= item_repo.find_by_id(item_id)
    end

  end
end
# references an item and an invoice
