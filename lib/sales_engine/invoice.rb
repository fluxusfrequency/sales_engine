require_relative 'transaction'
require_relative 'invoice_item'
require_relative 'item'
require_relative 'customer'
require_relative 'merchant'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'item_repository'
require_relative 'customer_repository'
require_relative 'merchant_repository'

class SalesEngine
  class Invoice
    attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :engine

    def initialize(data={}, engine)
      @id = data[:id]
      @customer_id = data[:customer_id]
      @merchant_id = data[:merchant_id]
      @status = data[:status]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
      @engine = engine
    end

    def transactions
      tran_repo = engine.transaction_repository
      tran_repo.find_all_by_invoice_id(id)
    end

    def invoice_items
      @inv_repo = engine.invoice_items_repository
      @inv_repo.find_all_by_invoice_id(id)
    end

    def items
      item_repo = ItemRepository.new('./test/fixtures/item_repository_fixture.csv')
      invoice_items.collect do |invoice_item|
        item_repo.find_by_id(invoice_item.item_id)
      end
    end

    def customer
      cust_repo = engine.customer_repository
      cust_repo.find_by_id(customer_id)
    end

    def merchant
      merch_repo = engine.merchant_repository
      merch_repo.find_by_id(merchant_id)
    end

  end
end

# connects the customer to multiple invoice items, one or more transactions, and one merchant
# At least one transaction where their credit card is charged. If the charge fails, more transactions may be created for that single invoice.
# One or more invoice items: one for each item that they ordered
