require_relative 'invoice'
require_relative 'invoice_repository'

module SalesEngine
  class Customer
    attr_reader :id, :first_name, :last_name, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id]
      @first_name = data[:first_name]
      @last_name = data[:last_name]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
    end

    def invoices
      inv_repo = InvoiceRepository.new('./test/fixtures/invoice_repository_fixture.csv')
      inv_repo.find_all_by_customer_id(id)
    end

  end
end
