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
      inv_repo = engine.invoice_item_repository
      inv_repo.find_all_by_invoice_id(id)
    end

    def items
      item_repo = engine.item_repository
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


# Given a hash of inputs, you can create new invoices on the fly using this syntax:
# invoice = invoice_repository.create(customer: customer, merchant: merchant, status: "shipped",
#                          items: [item1, item2, item3])

# Assuming that customer, merchant, and item1/item2/item3 are instances of their respective classes.

# You should determine the quantity bought for each item by how many times the item is in the :items array. So, for items: [item1, item1, item2], the quantity bought will be 2 for item1 and 1 for item2.

# Then, on such an invoice you can call:
# invoice.charge(credit_card_number: "4444333322221111",
#                credit_card_expiration: "10/13", result: "success")

# The objects created through this process would then affect calculations, finds, etc.
