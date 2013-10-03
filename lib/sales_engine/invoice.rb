require_relative '../sales_engine.rb'

class SalesEngine
  class Invoice

    attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

    def initialize(data={})
    end

  end
end