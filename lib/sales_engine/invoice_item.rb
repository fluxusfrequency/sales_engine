require_relative '../sales_engine.rb'

class SalesEngine
  class InvoiceItem

    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_s
      @item_id = data[:item_id].to_s
      @invoice_id = data[:invoice_id].to_s
      @quantity = data[:quantity].to_s
      @unit_price = data[:unit_price].to_s
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

  end
end