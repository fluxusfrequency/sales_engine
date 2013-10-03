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
      SalesEngine::Database.item_repository.find_all_by_merchant_id(id)
    end

    def invoices
      SalesEngine::Database.invoice_repository.find_all_by_merchant_id(id)
    end

    def revenue(date="default")
      if date == "default"
        revenue_without_date
      else
        revenue_with_date(date)
      end
    end

    def revenue_without_date
      total_invoices successful_invoices
    end

    def revenue_with_date(date)
      total_invoices successful_invoices_for_date(date)
    end

    def total_invoices(invoices)
      sum = invoices.collect {|invoice| invoice.total }.inject(0,:+)
      BigDecimal.new(sum / 100)
    end

    def successful_invoices_for_date(date)
      successful_invoices.find_all { |invoice| Date.parse(invoice.created_at) == date }
    end

    def customers_with_pending_invoices
      pending_invoices.collect { |i| i.customer }
    end

    def successful_invoices
      @successful_invoice ||= invoices.find_all { |invoice| invoice.successful? }
    end

    def pending_invoices
      @pending_invoices ||= invoices.find_all { |invoice| invoice.pending? }
    end

    # TODO: how can we do this without asking for the successful transactions
    def favorite_customer
      successful_customers = successful_invoices.collect do |invoice|
        invoice.customer
      end

      customer_hash = Hash.new(0)
      successful_customers.each do |customer|
        customer_hash[customer] += 1
      end

      customers = customer_hash.sort_by{ |customer, count| count }.reverse
      customers.flatten.first
    end

    def customers_with_successful_invoices

    end

    def transactions
      invoices.collect { |invoice| invoice.transactions }.flatten
    end

    # TODO: Could we remove this if we fix #favorite_customer
    def successful_transactions
      @successful_transactions ||= transactions.select { |transaction| transaction.successful? }
    end

    # TODO: Could we remove this if we fix #favorite_customer
    def successful_transaction_ids
      successful_transactions.collect {|transaction| transaction.id }
    end

    def pending_transactions
      failed_transactions.reject do |transaction|
        successful_transaction_ids.include?(transaction.id)
      end
    end

    def failed_transactions
      @failed_transactions ||= transactions.reject {|transaction| successful_transactions.include?(transaction)}
    end

    def successful_invoice_items
      successful_transactions.collect { |transaction| transaction.invoice.invoice_items }.flatten
    end


  end
end
