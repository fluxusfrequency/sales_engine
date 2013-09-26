require_relative 'invoice'
require_relative 'invoice_repository'
require_relative '../sales_engine.rb'


class SalesEngine
  class Customer
    attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :engine

    def initialize(data={}, engine)
      @id = data[:id]
      @first_name = data[:first_name]
      @last_name = data[:last_name]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
      @engine = engine
    end

    def invoices
      inv_repo = engine.invoice_repository
      inv_repo.find_all_by_customer_id(id)
    end

  end
end
