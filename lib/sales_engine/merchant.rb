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
        BigDecimal.new(revenue_without_date)
      else
        BigDecimal.new(revenue_with_date(date))
      end
    end

    def favorite_customer
      # returns the Customer who has conducted the most successful transactions
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
      # returns a collection of Customer instances which have pending (unpaid) invoices
      find_pending_invoices.collect { |i| i.customer }
    end

    def revenue_without_date
      # returns the total revenue for that merchant across all transactions
      rev = 0
      invoices.each do |invoice|
        invoice.transactions.each do |transaction|
          if transaction.result == "success"
            invoice.invoice_items.each do |inv_item|
              rev += (inv_item.quantity.to_i * inv_item.unit_price.to_i)
            end
          end
        end
      end
      rev /= 100
    end

    def revenue_with_date(date)
      #  returns the total revenue for merchant on a specific invoice date
      rev = 0
      invoices.each do |invoice|
        invoice.transactions.each do |transaction|
          if transaction.result == "success"
            invoice.invoice_items.each do |inv_item|
              if inv_item.created_at == date
                rev += (inv_item.quantity.to_i * inv_item.unit_price.to_i)
              end
            end
          end
        end
      end
      rev /= 100
    end

    def find_pending_invoices
      @pending_invoices ||= []

      if @pending_invoices.empty?
        invoices.each do |invoice|
          invoice.transactions.each do |transaction|
            unless transaction.result == "success"
              @pending_invoices << invoice
            end
          end
        end
      end
      @pending_invoices
    end

    def find_successful_invoices
      invoices - find_pending_invoices
    end

  end
end

# connected to many invoices and many items
