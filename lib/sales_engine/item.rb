require_relative 'merchant'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'merchant_repository'
require_relative '../sales_engine.rb'

class SalesEngine
  class Item
    attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :engine

    def initialize(data={}, engine)
      @id = data[:id]
      @name = data[:name]
      @description = data[:description]
      @unit_price = data[:unit_price]
      @merchant_id = data[:merchant_id]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
      @engine = engine
    end

    def invoice_items
      inv_item_repo = engine.invoice_item_repository
      inv_item_repo.find_all_by_item_id(id)
    end

    def merchant
      merchant_repo = engine.merchant_repository
      merchant_repo.find_by_id(merchant_id)
    end
  end
end
# connected to many invoice items and one merchant
