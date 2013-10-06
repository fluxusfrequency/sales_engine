require_relative '../sales_engine.rb'
require 'pry'

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
      @items ||= Database.item_repository.find_all_by_merchant_id(id)
    end

    def invoices
      @invoice ||= Database.invoice_repository.find_all_by_merchant_id(id)
    end

    def revenue(date="default")
      if date == "default"
        revenue_without_date
      else
        revenue_with_date(date)
      end
    end

    def favorite_customer
      Database.customer_repository.find_by_id(top_customer_id)
    end

    def successful_invoices_grouped_by_customer
      successful_invoices.group_by {|invoice| invoice.customer}
    end

    def count_customers
      successful_invoices.each_with_object(Hash.new(0)) do |invoice, counts|
        counts[invoice.customer_id] += 1
      end
    end

    def top_customer_id
      count_customers.max_by {|customer_id, count| count}.first
    end

    def transactions_on_successful_invoices_grouped_by_customer
      transactions_on_successful_invoices.group_by { |transaction| transaction.invoice.customer }
    end

    def customers_with_pending_invoices
      pending_invoices.collect {|invoice| invoice.customer }
    end

    def revenue_without_date
      total_up(successful_invoices)
    end

    def revenue_with_date(date)
      total_up(successful_invoices_on_date(date))
    end

    def total_up(invoices)
      sum = invoices.collect { |invoice| invoice.total }.inject(0,:+)
      BigDecimal.new(sum)/100
    end

    def successful_invoices
      invoices.select { |invoice| invoice.successful? }
    end

    def pending_invoices
      invoices.reject { |invoice| invoice.successful? }
    end

    def successful_invoices_on_date(date)
      successful_invoices.find_all { |invoice| invoice.created_at == date }
    end

    def items_on_successful_invoices
      successful_invoices.collect { |invoice| invoice.items }.flatten
    end

    def transactions_on_successful_invoices
      successful_invoices.collect { |invoice| invoice.transactions }.flatten
    end

  end
end