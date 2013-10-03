require_relative '../sales_engine.rb'

class SalesEngine
  class Item

    attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_i
      @name = data[:name]
      @description = data[:description]
      @unit_price = BigDecimal.new(data[:unit_price])/100
      @merchant_id = data[:merchant_id].to_i
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def invoice_items
      Database.invoice_item_repository.find_all_by_item_id(id)
    end

    def merchant
      Database.merchant_repository.find_by_id(merchant_id)
    end

  end
end