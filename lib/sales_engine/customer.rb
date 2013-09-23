require 'csv'

class Customer

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(id, first_name, last_name, created_at, updated_at)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @created_at = created_at
    @updated_at = updated_at
  end

  def invoices
  end

  def load(file)
    CSV.open(file, headers: true, header_converters: :symbol)
  end
end
