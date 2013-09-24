class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(id, name, description, unit_price, merchant_id, created_at, updated_at)
    @id = id
    @name = name
    @description = description
    @unit_price = unit_price
    @merchant_id = merchant_id
    @created_at = created_at
    @updated_at = updated_at
  end

  def invoice_items
  end

  def merchant
  end
end

# connected to many invoice items and one merchant
