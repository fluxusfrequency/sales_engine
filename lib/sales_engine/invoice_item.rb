require_relative '../sales_engine.rb'

class SalesEngine
  class InvoiceItem

    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id]
      @item_id = data[:item_id]
      @invoice_id = data[:invoice_id]
      @quantity = data[:quantity]
      @unit_price = BigDecimal.new(data[:unit_price])/100
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def invoice
      Database.invoice_repository.find_by_id(invoice_id)
    end

    def item
      Database.item_repository.find_by_id(item_id)
    end

  end
end