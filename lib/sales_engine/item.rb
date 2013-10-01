require_relative '../sales_engine.rb'
require 'time'

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
      SalesEngine::Database.invoice_item_repository.find_all_by_item_id(id)
    end

    def merchant
      SalesEngine::Database.merchant_repository.find_by_id(merchant_id)
    end

    def invoices
      invoice_items.collect do |invoice_item|
        invoice_item.invoice
      end
    end

    def best_day
      # returns the date with the most sales for the given item using the invoice date
      date_counts = Hash.new(0)
      successes = invoices.collect do |invoice|
        invoice.successful_transactions
      end

      successes.flatten.each_with_object(date_counts) do |transaction|
        date = Time.strptime(transaction.invoice.created_at, "%Y-%m-%d %H:%M:%S %z").to_date
        date_counts[date] += 1
      end

      sorted_dates = date_counts.sort_by {|date, count| count}
      sorted_dates.reverse.first.first
    end

    def revenue_generated
      # count the quantity * price of this item on each invoice item
      item_revenue = 0
      successful_invoice_items.each do |successful_invoice_item|
        item_revenue += successful_invoice_item.quantity.to_i * successful_invoice_item.unit_price.to_i
      end

      BigDecimal.new(item_revenue) / 100
    end

    def number_sold
      total = 0
      successful_invoice_items.each do |successful_invoice_item|
        total += successful_invoice_item.quantity.to_i
      end
      total
    end

    def successful_invoice_items
    # select only the invoices that belong to the merchant and were also successful

      successes = invoices.select do |invoice|
        invoice.successful? && invoice.merchant_id == merchant.id
      end

      successful_invoice_items = successes.collect do |invoice|
        invoice.invoice_items
      end

      successful_invoice_items.flatten
    end

  end
end
# connected to many invoice items and one merchant
