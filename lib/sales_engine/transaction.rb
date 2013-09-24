require_relative 'invoice'
require_relative 'invoice_repository'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(data={})
    @id = data[:id]
    @invoice_id = data[:invoice_id]
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def invoice
    inv_repo = InvoiceRepository.new('./test/fixtures/invoice_repository_fixture.csv')
    inv_repo.find_by_id(invoice_id)
  end

end

# references only the invoice
