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
      @invoices ||= Database.invoice_repository.find_all_by_customer_id(id)
    end

    def transactions
      @transactions ||= invoices.collect(&:transactions).flatten
    end

    def favorite_merchant
      most_invoices = successful_invoices_grouped_by_merchant.values.max(&:length)
      successful_invoices_grouped_by_merchant.key(most_invoices)
    end

    def successful_invoices
      invoices.select(&:successful?)
    end

    private

    def successful_invoices_grouped_by_merchant
      successful_invoices.group_by(&:merchant)
    end

  end
end