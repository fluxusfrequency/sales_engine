require_relative '../sales_engine.rb'

class SalesEngine
  class InvoiceItem

    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

    def initialize(data={})
    end

  end
end