require_relative '../sales_engine.rb'

class SalesEngine
  class Merchant

    attr_reader :id, :name, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_i
      @name = data[:name]
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def items
      Database.item_repository.find_all_by_merchant_id(id)
    end

    def invoices
      Database.invoice_repository.find_all_by_merchant_id(id)
    end

  end
end