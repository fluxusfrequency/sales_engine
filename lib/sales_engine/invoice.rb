class Invoice
  def transactions
  end

  def invoice_items
  end

  def items
  end

  def customer
  end

  def merchant
  end

end

# connects the customer to multiple invoice items, one or more transactions, and one merchant
# At least one transaction where their credit card is charged. If the charge fails, more transactions may be created for that single invoice.
# One or more invoice items: one for each item that they ordered
