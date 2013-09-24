class Merchant
  attr_reader :id, :name, :created_at, :updated_at

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def items
    true
  end

  def invoices
    true
  end

  def revenue
    true
    # BigDecimal
  end

end

# connected to many invoices and many items
