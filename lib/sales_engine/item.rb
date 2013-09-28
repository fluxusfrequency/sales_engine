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

    def best_day
      # returns the date with the most sales for the given item using the invoice date
      date_counts = Hash.new(0)
      invoice_items.each do |invoice_item|
        results = invoice_item.invoice.successful_transactions
        results.each_with_object(date_counts) do |successful_transaction|
          date_counts[successful_transaction.created_at] += 1
        end
      end
      sorted_dates = date_counts.sort_by {|date, count| count}
      sorted_dates.last[0]
    end

    def revenue_generated
      # find the merchant that owns this item (merchant)
      # find all of the successful invoices for that merchant
      successful_invoices = merchant.invoices - merchant.find_pending_invoices

      # find all of the invoice items that match this item (invoice_items)
      # find all of the invoices that contain those invoice items (invoices_with_this_item)
      invoices_with_this_item = invoice_items.collect { |invoice_item| invoice_item.invoice }

      # select only the invoices that belong to the merchant and were also successful
      matching_invoices = []
      invoices_with_this_item.each do |invoice|
        successful_invoices.each do |suc_inv|
          if suc_inv.id == invoice.id
            matching_invoices << invoice
          end
        end
      end

      # select only invoice_items that were on successful invoices
      successful_invoice_items = []
      invoice_items.each do |invoice_item|
        matching_invoices.each do |matching_invoice|
          if matching_invoice.id == invoice_item.invoice_id
            successful_invoice_items << invoice_item
          end
        end
      end

      # count the quantity * price of this item on each invoice item
      item_revenue = 0
      successful_invoice_items.each do |successful_invoice_item|
        item_revenue += successful_invoice_item.quantity.to_i * successful_invoice_item.unit_price.to_i
      end

      item_revenue /= 100
      BigDecimal.new(item_revenue)
    end

  end
end
# connected to many invoice items and one merchant
