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

    def revenue(date="default")
      if date == "default"
        revenue_without_date
      else
        revenue_with_date(date)
      end
    end

    def revenue_without_date
      total_up(successful_invoices)
    end

    def total_up(invoices)
      sum = invoices.collect {|invoice| invoice.total }.inject(0,:+)
      BigDecimal.new(sum)/100
    end

    def successful_invoices
      invoices.select { |invoice| invoice.successful? }
    end

  end
end