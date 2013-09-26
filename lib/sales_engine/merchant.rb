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
      item_repo = engine.item_repository
      item_repo.find_all_by_merchant_id(id)
    end

    def invoices
      inv_repo = engine.invoice_repository
      inv_repo.find_all_by_merchant_id(id)
    end

    def revenue
      # returns the total revenue for that merchant across all transactions
      revenue = BigDecimal.new(100)
      invoices.each do |invoice|
        invoice.invoice_items.each do |inv_item|
          revenue += BigDecimal.new(inv_item.quantity.to_i * inv_item.unit_price.to_i)
        end
      end
      revenue / 100
    end

    # def revenue(date)
    #   returns the total revenue for that merchant for a specific invoice date
    # end

    # def favorite_customer
    #   returns the Customer who has conducted the most successful transactions
    # end

    # def customers_with_pending_invoices
    #   returns a collection of Customer instances which have pending (unpaid) invoices
    # end

    # NOTE: Failed charges should never be counted in revenue totals or statistics.

    # NOTE: All revenues should be reported as a BigDecimal object with two decimal places.

  end
end
# connected to many invoices and many items
