require_relative 'merchant'

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
    []
  end

  def merchant
    @merchant = Merchant.new({})
  end
end

# connected to many invoice items and one merchant
