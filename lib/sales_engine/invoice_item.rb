class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(data)
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def invoice
    inv_repo = InvoiceRepository.new('./test/fixtures/invoice_repository_fixture.csv')
    inv_repo.find_by_id(invoice_id)
  end

  def item
    item_repo = ItemRepository.new('./test/fixtures/item_repository_fixture.csv')
    item_repo.find_by_id(item_id)
  end

end

# references an item and an invoice
