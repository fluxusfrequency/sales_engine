require_relative 'merchant'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'merchant_repository'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(data={})
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def invoice_items
    inv_item_repo = InvoiceItemRepository.new('./test/fixtures/invoice_repository_fixture.csv')
    # inv_repo.find_all_by_item_id(id)

    # delete the line below when Invoice Repository is ready
    [Invoice.new({})]
  end

  def merchant
    merchant_repo = MerchantRepository.new('test/fixtures/merchant_repository_fixture.csv')
    merchant_repo.find_by_id(merchant_id)
  end
end

# connected to many invoice items and one merchant
