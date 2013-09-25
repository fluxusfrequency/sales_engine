require_relative 'item'
require_relative 'invoice'
require_relative 'item_repository'
require_relative 'invoice_repository'

module SalesEngine
  class Merchant
    attr_reader :id, :name, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id]
      @name = data[:name]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
    end

    def items
      item_repo = ItemRepository.new('./test/fixtures/item_repository_fixture.csv')
      item_repo.find_all_by_merchant_id(id)
    end

    def invoices
      inv_repo = InvoiceRepository.new('./test/fixtures/invoice_repository_fixture.csv')
      inv_repo.find_all_by_merchant_id(id)
    end

    def revenue
      BigDecimal.new(100)
      # BigDecimal
    end
    # NOT SURE IF THIS IS STILL PART OF THE PROJECT

  end
end
# connected to many invoices and many items
