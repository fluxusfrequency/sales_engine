class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(data={})
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = data[:data]
    @updated_at = data[:updated_at]
  end

  def transactions
    true
  end

  def invoice_items
    true
  end

  def items
    true
  end

  def customer
    true
  end

  def merchant
    true
  end

end

# connects the customer to multiple invoice items, one or more transactions, and one merchant
# At least one transaction where their credit card is charged. If the charge fails, more transactions may be created for that single invoice.
# One or more invoice items: one for each item that they ordered
