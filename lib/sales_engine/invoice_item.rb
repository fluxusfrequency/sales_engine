class SalesEngine
  class InvoiceItem

    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_i
      @item_id = data[:item_id].to_i
      @invoice_id = data[:invoice_id].to_i
      @quantity = data[:quantity].to_i
      @unit_price = BigDecimal.new(data[:unit_price])/100
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def invoice
      @invoice ||= Database.invoice_repository.find_by_id(invoice_id)
    end

    def item
      @invoice ||= Database.item_repository.find_by_id(item_id)
    end

    def total
      quantity * (unit_price * 100)
    end

    def successful?
      invoice.successful? unless invoice.nil?
    end

  end
end