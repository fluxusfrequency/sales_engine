class Merchant
  attr_reader :id, :name, :created_at, :updated_at

  def initialize(id, name, created_at, updated_at)
    @id = id
    @name = name
    @created_at = created_at
    @updated_at = updated_at
  end

  def items
  end

  def invoices
  end

  def revenue
    # BigDecimal
  end

end

# connected to many invoices and many items
