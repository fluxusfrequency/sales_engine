require_relative '../sales_engine.rb'

class SalesEngine
  class Customer

    attr_reader :id, :first_name, :last_name, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_i
      @first_name = data[:first_name]
      @last_name = data[:last_name]
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def invoices
      Database.invoice_repository.find_all_by_customer_id(id)
    end

    def transactions
      @transactions ||= invoices.collect { |invoice| invoice.transactions }.flatten
    end

    def favorite_merchant
      most_invoices = successful_invoices_grouped_by_merchant.values.max {|v| v.length}
      successful_invoices_grouped_by_merchant.key(most_invoices)
    end

    def successful_invoices
      invoices.select {|invoice| invoice.successful? }
    end

    def successful_invoices_grouped_by_merchant
      # {<merchant1> => [<invoice1>, <invoice2>], <merchant2> => [<invoice3>]}
      successful_invoices.group_by {|invoice| invoice.merchant }
    end

  end
end