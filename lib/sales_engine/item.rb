require_relative '../sales_engine.rb'

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

    def successful_invoices
      @successful_invoices ||= invoices.compact.select {|invoice| invoice.successful? }
    end

    def successful_invoice_items
      @successful_invoice_items ||= successful_invoices.collect { |invoice| invoice.invoice_items}.flatten
    end

    def successful_transactions
      successes = invoices.collect do |invoice|
        invoice.successful_transactions if invoice.successful?
      end
      successes.flatten
    end

    def count_invoice_item_quantity_sold_for_date
      date_counts = Hash.new(0)
      successful_invoice_items.each_with_object(date_counts) do |invoice_item|
        date = Time.strptime(invoice_item.invoice.created_at, "%Y-%m-%d %H:%M:%S %z").to_date
        date_counts[date] += invoice_item.quantity.to_i*invoice_item.unit_price.to_i
      end
    end

    def best_day
      sorted_dates = count_invoice_item_quantity_sold_for_date.sort_by {|date, count| count}.reverse

      sorted_dates.flatten.first
    end

    def revenue_generated
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

  end
end
