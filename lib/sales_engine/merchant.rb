require_relative '../sales_engine.rb'
require 'bigdecimal'

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
        BigDecimal.new(revenue_without_date) / 100
      else
        BigDecimal.new(revenue_with_date(date)) / 100
      end
    end

    def revenue_without_date
      rev = 0
      successful_invoice_items.each do |inv_item|
        rev += (inv_item.quantity.to_i * inv_item.unit_price.to_i)
      end
      rev
    end

    def revenue_with_date(date)
      rev = 0
      successful_invoice_items.each do |inv_item|
        if inv_item.created_at == date
          rev += (inv_item.quantity.to_i * inv_item.unit_price.to_i)
        end
      end
      rev
    end

    def transactions
      tr = invoices.collect do |invoice|
        invoice.transactions
      end
      tr.flatten
    end

    def favorite_customer
      customer_hash = Hash.new(0)
      invoices.each_with_object(customer_hash) do |invoice|
        invoice.transactions.each do |transaction|
          if transaction.result == "success"
            customer_hash[invoice.customer] += 1
          end
        end
      end
      customer_hash.sort_by{ |customer, count| count }.first.first
    end

    def customers_with_pending_invoices
      pending_invoices.collect { |i| i.customer }
    end

    def successful_invoices
      invoices - pending_invoices
    end

    def pending_invoices
      p_invoices ||= []

      if p_invoices.empty?
        p_invoices = pending_transactions.collect { |transaction| transaction.invoice }
      end

      p_invoices
    end

    def successful_transactions
      transactions.select { |transaction| transaction.successful? }
    end

    def pending_transactions
      transactions = successful_transactions
    end

    def successful_invoice_items
      successful_transactions.collect { |transaction| transaction.invoice.invoice_items }.flatten
    end

  end
end
