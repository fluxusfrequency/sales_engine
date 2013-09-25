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

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(data)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def transactions
    tran_repo = TransactionRepository.new('./test/fixtures/transaction_repository_fixture.csv')
    tran_repo.find_all_by_invoice_id(id)
  end

  def invoice_items
    @inv_repo = InvoiceItemRepository.new('./test/fixtures/invoice_item_repository_fixture.csv')
    @inv_repo.find_all_by_invoice_id(id)
  end

  def items
  # This has to get called through the invoice items somehow
  # @inv_repo.find_all_by_item_id()
    true
  end

  def customer
    cust_repo = CustomerRepository.new('./test/fixtures/customer_repository_fixture.csv')
    cust_repo.find_by_id(customer_id)
  end

  def merchant
    merch_repo = MerchantRepository.new('./test/fixtures/merchant_repository_fixture.csv')
    merch_repo.find_by_id(merchant_id)
    # binding.pry
  end

end

# connects the customer to multiple invoice items, one or more transactions, and one merchant
# At least one transaction where their credit card is charged. If the charge fails, more transactions may be created for that single invoice.
# One or more invoice items: one for each item that they ordered
