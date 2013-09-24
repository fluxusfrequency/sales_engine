require_relative 'item'
require_relative 'invoice'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at

  def initialize(data={})
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def items
    [Item.new({})]
  end

  def invoices
    [Invoice.new({})]
  end

  def revenue
    BigDecimal.new(100)
    # BigDecimal
  end

end

# connected to many invoices and many items
