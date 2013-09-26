require_relative 'item'
require_relative 'invoice'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative '../sales_engine.rb'

class SalesEngine
  class Merchant
    attr_reader :id, :name, :created_at, :updated_at, :engine

    def initialize(data={}, engine)
      @id = data[:id]
      @name = data[:name]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
      @engine = engine
    end

    def items
      item_repo = engine.item_repository
      item_repo.find_all_by_merchant_id(id)
    end

    def invoices
      inv_repo = engine.invoice_repository
      inv_repo.find_all_by_merchant_id(id)
    end

    def revenue
      revenue = BigDecimal.new(100)
      # revenue / 100
    end

  end
end
# connected to many invoices and many items
